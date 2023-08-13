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
    # print(f'args is {args}')
    title=args[1]
    cwd=args[2]
    tabColour=args[3]
    exe=args[4]
    exe_arg=args[5]

    tab = get_tab(boss, title)

    if tab: # if tab exists
        if boss.active_tab.title == title: # if tab is active
            boss.goto_tab(0) # go to previous active tab
        else:
            boss.set_active_tab(tab)
    else: # create a new tab
        boss.launch(
        "--type=tab",
        f"--title={title}",
        f"--cwd={cwd}",
        exe,
        exe_arg,
        )
        tab = get_tab(boss, title)
        colour_tab(boss, tab, tabColour)

def get_tab(boss: Boss, title):
    tabs = boss.match_tabs(f'title:^{title}')
    tab = next(tabs, None) # default value for generator to None instead of throwing StopIteration error
    return tab

def colour_tab(boss: Boss, tab, tabColour) -> None:
    colour = int(to_color(tabColour, validate=True))
    # tab.active_fg = colourBlack
    # tab.inactive_fg = colourPink
    tab.active_bg = colour
    tab.inactive_fg = colour
    redraw_tab_bar(boss)
