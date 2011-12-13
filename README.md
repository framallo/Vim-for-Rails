# The awesome Vim config files

This will allow you to run mac vim and develop on Ruby on Rails.

Some features include:

* nice theme for gui and terminal with 16 colors. (ir_black and xterm16)
* incremental Search that ignore case by default
* Swap and backup out of your way

to install:
you need to install macvim. If you are using OSX with macports you can run:
sudo port install macvim +ruby

WARNING: The +ruby variant depends on ruby from macport! this could reinstall a new ruby env!
You only require ruby support for command-t plugin. So you could remove +ruby to install it without ruby support:

then add the config files:

git clone git://github.com/framallo/Vim-for-Rails.git ~/.vim

    cd ~/.vim
    git submodule init
    git submodule update

Then you need to load on ~/.vimrc. e.g.:

    source ~/.vim/vim-for-rails.vim

    " solarized dark background
    colorscheme solarized
    set background=dark

Then you need to load on ~/.gvimrc. e.g.:

    source ~/.vim/gvim-for-rails.vim


# USAGE

    jj = <esc>  Very useful for keeping your hands on the home row          
    ,n = toggle NERDTree off and on                                         
    ,f = fuzzy find all files                                               
    ,b = fuzzy find in all buffers                                          
    ,p = go to previous file                                                
    ,t = toogle taglist                                                     
                                                                            
    hh = inserts '=>'                                                       
    aa = inserts '@'                                                        
                                                                            
    ,h = new horizontal window                                              
    ,v = new vertical window                                                
                                                                            
    ,i = toggle invisibles                                                  
                                                                            
    enter and shift-enter = adds a new line after/before the current line   
                                                                            
    :call Tabstyle_tabs = set tab to real tabs                              
    :call Tabstyle_spaces = set tab to 2 spaces                             

# Keyboard Layout

I use english keyboard layout since is the most efficient layout for development.
Also I use the Caps Lock key as control key. 


# Wish List

Things i want to include, build, improve, etc

* Git grep inside vim 
* mvim should open a new tab and pwd should be set to the current file
* running 'mvim' or 'mvim .' should open the NERDTREE by default and an empty window on the right


# See it

!http://s3.amazonaws.com/tangosource_pm/100824164544/100824164544_Screen_shot_2010-08-24_at_11.36.20_AM.png!



# Thanks

Thanks to twerth for his config files 
Thanks to Rafa for introducing me to the world of mac and spending some time testing this config! :D

