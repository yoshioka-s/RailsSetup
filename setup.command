dir=`pwd`
logfile="$dir/setup.log"
echo "logging to $logfile"

echo "SETUP START!"
echo "SETUP START!" > $logfile

## Git install  ##
echo "START: Git install!"
echo "START: Git install!" >> $logfile
whichgit=`which git`
git --version >> $logfile

## Git config  ##
echo "START: Git setting!" >> $logfile
echo "Your Git user name please:"
read fname
echo $fname >> $logfile
git config --global user.name "$fname"
echo "Your email address please:"
read femail
echo $femail >> $logfile
git config --global user.email "$femail"
git config --global color.ui auto
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.hist log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
cat ~/.gitconfig >> $logfile
echo "FINISH: Git set up completed!" >> $logfile

## Ruby install  ##
echo "START: Ruby install!" >> $logfile
echo "START: Ruby install!"
# rbenv install  #
whichrbenv=`which rbenv`
if [[ $whichrbenv ]]; then
  echo "rbenv is already installed." >> $logfile
  echo $whichrbenv >> $logfile
else
  echo "installing rbenv" >> $logfile
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv >> $logfile
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  source ~/.bashrc
  type rbenv >> $logfile
fi

# ruby-build install  #
if [[ -e ~/.rbenv/plugins/ruby-build ]]; then
  echo "ruby-build is already installed." >> $logfile
else
  echo "installing ruby-build..." >> $logfile
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build >> $logfile
fi
ruby -v >> $logfile
echo "FINISH: Rubyenv has been installed!" >> $logfile

rbenv install -l
echo "type ruby version to install"
read fversion
echo $fversion >> $logfile
rbenv install $fversion

gem install bundler
gem env home
