#!/usr/local/bin/perl
use 5.14.2;
use strict;
use warnings;
use utf8;
use Net::POP3;
use Net::POP3::SSLWrapper;
# メールサーバとアカウントの設定
my $server   = 'pop3.live.com';
my $account  = 's2otsa@hotmail.com';
my $password = 'litas2';
my $protocol = 'pop3';        # pop3/apop
my $output   = './mail';      # 保存先ディレクトリ


pop3s{
    # Constructors
    warn "try to connect";
    my $pop = Net::POP3->new(Host => $server , Timeout => 60 , Port => 995) or die "can't connect";
    warn "connected";
    if($pop->login($account , $password) > 2){
        warn "logined";
        warn "read messages";
        my $msgnums = $pop->list;
        use Data::Dumper;
        warn Dumper $msgnums;
        
        $pop->quit;
    }else{
        die "can't login";
    }
}
