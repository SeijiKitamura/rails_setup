#/bin/bash

cd `dirname $0`

echo "現在のディレクトリは `pwd` です"


function yes_no_while(){
  while true;do
    read -p "Railsアプリ名:" RAILS_APP

    if [ ${#RAILS_APP} -eq 0 ];then
      echo "アプリ名を再度入力してください。"
      echo "終了する場合はCtrl+Cを押してください。"
      yes_no_while
    fi
    
    read -p "Railsバージョン:" RAILS_VERSION
    if [ ${#RAILS_VERSION} -eq 0 ];then
      echo "バージョンを指定していないため最初からになります。"
      echo "終了する場合はCtrl+Cを押してください。"
      yes_no_while
    fi
    
    read -p "Railsアプリ名: ${RAILS_APP}(${RAILS_VERSION}) で作成しますか?(y/n)" ANSER
    
    case $ANSER in
      y)
        #Rails インストール
        rails _${RAILS_VERSION}_ new ../${RAILS_APP} --skip-bundle

        #git
        cd ./${RAILS_APP}
        git init
        git add .
        git commit -m "first commit"
        cd ..

        #設定ファイルコピー
        rm ../${RAILS_APP}/app/views/layouts/application.html.erb
        cp application.html.slim ../${RAILS_APP}/app/views/layouts/
        cp application.js ../${RAILS_APP}/app/assets/javascripts/
        cp custom.css.scss ../${RAILS_APP}/app/assets/stylesheets/
        cp Gemfile ../${RAILS_APP}/
        cp puma.rb ../${RAILS_APP}/config/
        mkdir ../${RAILS_APP}/tmp/sockets
        mkdir ../${RAILS_APP}/tmp/pids

        ABS_PATH=$(cd ../${RAILS_APP} && pwd)

        #puma自動起動
        echo "puma自動起動コマンドをcronに書き込みます"
        crontab -l > cron.txt
        cat sample_cron.txt | sed -e "s:_app_dir_:${ABS_PATH}:g" >> cron.txt
        crontab cron.txt
        rm cron.txt

        #nginx設定
        cat nginx_sample.conf                 | 
        sed -e "s:_app_dir_:${ABS_PATH#*/}:g" |
        sed -e "s/_sample_app_/${RAILS_APP}/g" > ${RAILS_APP}.conf
        echo "nginx用設定ファイル「${RAILS_APP}.conf」を作成し/etc/nginx/conf.dへコピーします"
        sudo cp ${RAILS_APP}.conf /etc/nginx/conf.d/ 
        sudo systemctl restart nginx
        rm ${RAILS_APP}.conf

        #終了メッセージ
        echo "作成しました。以下のコマンドを実行してください"
        echo " cd ${ABS_PATH}"
        echo " bundle install"
        echo " rails db:create"
        echo " rails assets:precompile"
        echo ' SECRET_KEY_BASE=`rake secret` RAILS_ENV=production bundle exec puma -C config/puma.rb -d'
        break
        ;;
      *)
        echo "最初に戻ります。終了する場合はCtrl+Cを押してください"
        yes_no_while
        ;;
    esac
  done
}

yes_no_while
