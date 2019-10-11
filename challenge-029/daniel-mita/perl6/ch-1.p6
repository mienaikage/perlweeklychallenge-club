#!/usr/bin/env perl6
use v6;

grammar Brace {
  regex TOP { <start> [ '{' <brace> '}' <end> ] * }
  regex start { <-[{]>*? }
  regex end { <-[}]>*? }
  regex brace { <TOP> }
}

#| Expand braces (nesting NYI)
sub MAIN (
  *@phrase where * > 0,
  --> Nil
) {
  given @phrase.join: ' ' -> $str {
    say Brace.parse($str);
    exit;
    given $str.match: /^ ( .*? ) [ '{' ( .*? ) '}' ( .*? ) ]* $/ {
      .say;
      when .[1].so {
        for .[1].split: ',' -> $split {
          "$_[0]$split$_[2]".say;
        }
      }
      default { $str.say }
    }
  }
}
