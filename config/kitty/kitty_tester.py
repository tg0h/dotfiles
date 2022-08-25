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
    
@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    # go to tab named 'wiki'
    # if tab does not exist, create the tab
    # if currently focussed tab is the 'wiki' tab, then go to previous tab
    # change the 'wiki' tab colour

    # print(f'active tab is {boss.active_tab}')
    tm = boss.active_tab_manager
    tabLength=len(tm.tabs)
    print(f'there are {len(tm.tabs)} tabs')
    i = 1
    print('---')
    wikiTabPosition=None
    for tab in tm.tabs:
        print(f'tab i is {i}')
        print(f'tab id is {getattr(tab,"id","oops")}')
        print(f'tab title is {getattr(tab,"title","oops")}')
        if getattr(tab,"title",None) == 'wiki':
            wikiTabPosition=i
        i+=1

    print('---')
    print()
        

    # colourOrange = int(to_color('orange', validate=True))
    # colourBlack = int(to_color('black', validate=True))

    if (wikiTabPosition and tabLength > wikiTabPosition):
            current_position=wikiTabPosition
            while (current_position < tabLength):
                boss.move_tab_forward() # this moves the currently focussed tab (which may not be wiki )
                current_position+=1


    is_wiki_focussed=False
    if boss.active_tab.title == 'wiki':
        is_wiki_focussed=True

    tabs = boss.match_tabs('title:^wiki')
    tab = next(tabs, None) # default value for generator to None instead of throwing StopIteration error
    print(f'wiki tab is {tab}')
    print(f'wiki tab id is {getattr(tab,"id","oops")}')
    # boss.move_tab_forward()

    # if tab:
    #     tab.inactive_bg = colourOrange
    #     tab.inactive_fg = colourBlack
    #     tab.active_fg = colourBlack
    #     tab.active_bg = colourOrange
    #     redraw_tab_bar(boss)
    #     if not is_wiki_focussed:
    #         boss.set_active_tab(tab)
    #     else:
    #         print('going to prev active tab')
    #         # boss._move_tab_to(tab, target_window_id)
    #         # to go to previous active tab
    #         # unlike goto_tab -1, boss.goto_tab uses 0 instead
    #         boss.goto_tab(0) # go to previous active tab
    # else:
    #     boss.launch(
    #     "--type=tab",
    #     "--title=wiki",
    #     "--cwd=/Users/tim/src/me/wiki",
    #     )
