#!/bin/zsh

pp(){
# for f in ~/.local/lib/zsh/***/*; 
# do [[ -f $f ]] 
#   echo $f
#   . $f; 
# done

# for f in ~/.local/lib/abs/***/*.zsh; 
# do [[ -f $f ]] 
#   echo $f
#   . $f; 
# done
}

tt(){
  # echo hello
  # echo $_fzf_homeFn_dir
  # rg \
  #   --type zsh \
  #   --color always \
  #   --field-context-separator '' \
  #   --no-context-separator \
  #   # --only-matching -e '^\s*function\s+(?P<fname>([^\s(]+))' -r '$fname' -A 1 \
  #   --only-matching  '^\s*function\s+' 
  #   --field-match-separator ' ' \
  #   $_fzf_homeFn_dir \
    # | gsed -E 's!(\s*)(#)!\2!' \
    # | gsed "s!$_fzf_homeFn_dir!!" \
    # | gsed 'N;s/\n/ /' \
    # | gawk '{$3="-"; print}' 
}

