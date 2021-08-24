// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '@fortawesome/fontawesome-free/js/all'
require('jquery')

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", function() {
  $(function() {
    setTimeout("$('.flash').fadeOut('slow')", 2000);

    // MENUボタンがクリックされたときの処理
    $('#side_menu_btn').on('click', function(){
      if($(this).hasClass('active')) {
        $(this).removeClass('active');
        $('#side_menu').removeClass('open');
        $('#menu_background').removeClass('open');
      } else {
        $(this).addClass('active');
        $('#side_menu').addClass('open');
        $('#menu_background').addClass('open');
      }
    });

    // メニューの背景がクリックされたときの処理
    $('#menu_background').on('click', function(){
      if($(this).hasClass('open')) {
        $(this).removeClass('open');
        $('#side_menu_btn').removeClass('active')
        $('#side_menu').removeClass('open');
      }
    });

    // パスワードの表示/非表示
    $('.js-password').on('change', function(){
      if ( $(this).prop('checked') ) {
        $(this).siblings('input[type="password"]').attr('type','text');
      } else {
        $(this).siblings('input[type="text"]').attr('type','password');
      }
    });
  });
});