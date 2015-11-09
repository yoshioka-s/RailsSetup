dir=`pwd`
logfile="$dir/setup.log"
echo "logging to $logfile"

echo "SETUP START!"
echo "SETUP START!" > $logfile

## Git install  ##
echo "START: Git install!"
echo "START: Git install!" >> $logfile
# sudo apt-get update >> $logfile
whichgit=`which git`
if [[ $whichgit ]]; then
  echo "git is already installed." >> $logfile
  echo $whichgit >> $logfile
else
  echo "installing git..." >> $logfile
  sudo apt-get install git >> $logfile
  git --version >> $logfile
  echo "FINISH: Git have been installed!" >> $logfile

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
fi

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
echo "FINISH: Ruby has been installed!" >> $logfile

## clone the project  ##
echo "START: Set up the project!" >> $logfile
echo "START: Set up the project!"
dir=`pwd`
echo "Your remote origin please:"
read origin
echo "cloning the project into $dir" >> $logfile
git clone $origin >> $logfile
cd hyaku
rbenv install 2.2.3 >> $logfile
rbenv local 2.2.3

# bundle install #
echo "bundle install! This may take some time..."
echo "bundle install!" >> $logfile
bundle install >> $logfile
echo "FINISH: bundle install!"
echo "FINISH: bundle install!" >> $logfile

echo "DB create!" >> $logfile
rake db:create >> $logfile
echo "DB migrate!" >> $logfile
rake db:migrate >> $logfile
echo "DB seed!" >> $logfile
rake db:seed >> $logfile
echo "FINISH: the project has been set up!" >> $logfile

echo "SET UP FINISHED!"
echo "SET UP FINISHED!" >> $logfile

## Start the server ##
echo "START Rails SERVER!!"
echo "START Rails SERVER!!" >> $logfile
echo "Open 'localhost:3000' in your browser!"
rails server
