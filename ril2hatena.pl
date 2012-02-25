use strict;
use warnings;
use utf8;
use Encode;
use Config::Pit;
use WebService::RIL;
use WebService::Hatena::Bookmark::Lite;

my $config_ril = pit_get('RIL');
my $ril = WebService::RIL->new(
    user => $config_ril->{user},
    pass => $config_ril->{pass},
    apikey => $config_ril->{apikey},
);

my $config_hatena = pit_get('hatena');
my $bookmark = WebService::Hatena::Bookmark::Lite->new(
    username => $config_hatena->{username},
    password => $config_hatena->{password},
);

# Read It Laterから未読リストを取得
my $list = $ril->get_list(
    state => 'unread',
);

# Read It Laterの未読URLをはてブに追加
for my $item (@{$list->{'list'}}) {
    $bookmark->add(
        url => $item->{url},
    );
}

