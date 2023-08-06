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
        tabTitle = getattr(tab,"title",None) 
        if tabTitle == 'wiki' or tabTitle == 'candy_wiki':
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
    # print(f'wikiFolder is {wikiFolder}')
    tm = boss.active_tab_manager
    # print(f'there are {len(tm.tabs)} tabs')
    # for tab in tm.tabs:
    #     print(f'tab id is {getattr(tab,"id","oops")}')

    is_wiki_focussed=False
    if boss.active_tab.title == 'wiki' or boss.active_tab.title == 'candy_wiki':
        is_wiki_focussed=True

    tab = get_wiki_tab(boss)
    # print(f'tab is {tab}')
    # if tab is not None:
    #     tabTitle=tab.title
    #     print(f'tab title is {tab.title}')

    # print(f'args is {args}')

    if tab:
        colour_tab(boss, tab)
        is_wiki_focussed=False
        if boss.active_tab.title == 'wiki' or boss.active_tab.title == 'candy_wiki':
            is_wiki_focussed=True
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
        wikiArg=args[1] # these are the args passed to the tab_switcher kitten
        if wikiArg == 'wiki':
            wikiFolder='/Users/tim/src/me/wiki'
            wikiTitle='wiki'
        else:
            wikiFolder='/Users/tim/Documents/candy/wiki'
            wikiTitle='candy_wiki'
        boss.launch(
        "--type=tab",
        f"--title={wikiTitle}",
        f"--cwd={wikiFolder}",
        "nvim",
        "-c",
        "lua open_latest_changed_file()", # run my lua script
        )
        tab = get_wiki_tab(boss)
        if tab:
            colour_tab(boss, tab)

def get_wiki_tab(boss: Boss):
    tabs = boss.match_tabs('title:^wiki or title:^candy_wiki')
    # print(f'tabs is {tabs}')
    tab = next(tabs, None) # default value for generator to None instead of throwing StopIteration error
    return tab

def colour_tab(boss: Boss, tab) -> None:
    colourOrange = int(to_color('orange', validate=True))
    colourPink = int(to_color('pink', validate=True))
    colourBlack = int(to_color('black', validate=True))

    tab.active_fg = colourBlack
    if tab.title == 'wiki':
        tab.inactive_fg = colourOrange
        tab.active_bg = colourOrange
    else:
        tab.inactive_fg = colourPink
        tab.active_bg = colourPink
    redraw_tab_bar(boss)
