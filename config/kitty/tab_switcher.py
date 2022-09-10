from typing import List
from kitty.boss import Boss
from kittens.tui.loop import debug
from kittens.tui.handler import result_handler
from kitty.rgb import to_color

def main(args: List[str]):
    pass

def redraw_tab_bar(boss):
    tm = boss.active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()   

def get_wiki_tab_position(tabs):
    i=1
    for tab in tabs:
        if getattr(tab,"title",None) == 'wiki':
            return i
        i+=1
    return None

def move_wiki_tab_to_end(tabs, boss):
    # assumes that wikiTab is currently focussed
    tabLength = len(tabs)
    wikiTabPosition = get_wiki_tab_position(tabs)
    if wikiTabPosition == tabLength: # wiki tab is already at the rightmost tab
        return
    if (wikiTabPosition and tabLength > wikiTabPosition):
            current_position=wikiTabPosition
            while (current_position < tabLength):
                boss.move_tab_forward() # this moves the currently focussed tab (which may not be wiki )
                current_position+=1

    
@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    # go to tab named 'wiki'
    # if tab does not exist, create the tab
    # if currently focussed tab is the 'wiki' tab, then go to previous tab
    # change the 'wiki' tab colour

    # print(f'active tab is {boss.active_tab}')
    tm = boss.active_tab_manager
    # print(f'there are {len(tm.tabs)} tabs')
    # for tab in tm.tabs:
    #     print(f'tab id is {getattr(tab,"id","oops")}')

    colourOrange = int(to_color('orange', validate=True))
    colourBlack = int(to_color('black', validate=True))

    is_wiki_focussed=False
    if boss.active_tab.title == 'wiki':
        is_wiki_focussed=True

    tabs = boss.match_tabs('title:^wiki')
    tab = next(tabs, None) # default value for generator to None instead of throwing StopIteration error

    if tab:
        # tab.inactive_bg = colourOrange
        tab.inactive_fg = colourOrange
        tab.active_fg = colourBlack
        tab.active_bg = colourOrange
        redraw_tab_bar(boss)
        if not is_wiki_focussed:
            boss.set_active_tab(tab)
        else:
            # assumes that tab is wiki tab and is currently focussed
            move_wiki_tab_to_end(tm.tabs, boss)
            print('going to prev active tab')
            # boss._move_tab_to(tab, target_window_id)
            # to go to previous active tab
            # unlike goto_tab -1, boss.goto_tab uses 0 instead
            boss.goto_tab(0) # go to previous active tab
    else:
        boss.launch(
        "--type=tab",
        "--title=wiki",
        "--cwd=/Users/tim/src/me/wiki",
        # "nvim"
        )
