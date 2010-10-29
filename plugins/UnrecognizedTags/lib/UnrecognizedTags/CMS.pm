#############################################################################
# Copyright © 2008-2009 Six Apart Ltd.
# This program is free software: you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# version 2 for more details.  You should have received a copy of the GNU
# General Public License version 2 along with this program. If not, see
# <http://www.gnu.org/licenses/>.

package UnrecognizedTags::CMS;

use strict;
use warnings;
use MT::Util;

sub unrecognized_tags {
    my $app = shift;

    require MT::Template;
    require MT::Blog;

    my $tags  = {};
    my $tmpls = {};
    my $blogs = {};

    my $iter;
    if ( $app->blog ) {
        $iter = MT::Template->load_iter( { blog_id => $app->blog->id } );
    }
    else {
        $iter = MT::Template->load_iter();
    }
    while ( my $tmpl = $iter->() ) {
        $tmpl->compile;
        if ( $tmpl->{errors} && @{ $tmpl->{errors} } ) {

#print "Errors in " . $tmpl->id . "'" . $tmpl->name . "' (" . $tmpl->blog_id . ")\n";
            my @msgs = map {
                ( $_->{message} =~ /unrecognized/mi )
                  ? $_->{message}
                  : ()
            } @{ $tmpl->{errors} };
            for my $msg (@msgs) {
                my ($tag) = ( $msg =~ /^<([^>]+)>/ );
                $tags->{$tag} ||= {};
                $tags->{$tag}->{ $tmpl->id }++;
            }
            $tmpls->{ $tmpl->id } = $tmpl;
            $blogs->{ $tmpl->blog_id } ||= MT::Blog->load( $tmpl->blog_id );
        }
    }
    my @tag_loop = ();
    my $tag_count;
    my $instance_count;
    for my $tag ( sort keys %$tags ) {
        $tag_count++;
        my @tmpl_loop = ();
        for my $tmpl_id ( keys %{ $tags->{$tag} } ) {
            $instance_count++;
            my $tmpl = $tmpls->{$tmpl_id};

            push(
                @tmpl_loop,
                {   'name'      => $tmpl->name,
                    'id'        => $tmpl->id,
                    'blog_name' => ( $tmpl->blog_id )
                    ? $blogs->{ $tmpl->blog_id }->name
                    : "Global Templates",
                    'blog_id' => $tmpl->blog_id,
                }
            );
        }
        @tmpl_loop = sort {
            "$a->{'blog_name'}$a->{'name'}" cmp
              "$b->{'blog_name'}$b->{'name'}"
        } @tmpl_loop;
        push(
            @tag_loop,
            {   'tag'       => $tag,
                'count'     => scalar @tmpl_loop,
                'tmpl_loop' => \@tmpl_loop,
            }
        );
    }
    my $param = {
        'tag_count'      => $tag_count,
        'instance_count' => $instance_count,
        'tag_loop'       => \@tag_loop,
    };
    $app->{component} = 'UnrecognizedTags';
    return $app->build_page( 'results.tmpl', $param );
}

1;
