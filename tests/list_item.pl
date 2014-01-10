:- begin_tests(md_list_item).
:- use_module(prolog/md/md_list_item).

% Tests for span-level links.

md_bullet_list_item_string(String, Item, Mode, Rest):-
    string_codes(String, Codes),
    phrase(md_bullet_list_item(ItemCodes, ModeTmp), Codes, RestCodes), !,
    string_codes(Rest, RestCodes),
    string_codes(Item, ItemCodes),
    Mode = ModeTmp.

% Bullet list item. Star bullet.

test(list_item_1):-
    md_bullet_list_item_string("* abc", "abc", normal, "").

% Bullet list item. Plus bullet.

test(list_item_2):-
    md_bullet_list_item_string("+ abc", "abc", normal, "").

% Bullet list item. Minus bullet.

test(list_item_3):-
    md_bullet_list_item_string("- abc", "abc", normal, "").

% Bullet list item, indent before bullet.

test(list_item_4):-
    md_bullet_list_item_string("  * abc", "abc", normal, "").

% Bullet list item, more indent after bullet.

test(list_item_5):-
    md_bullet_list_item_string("*   abc", "abc", normal, "").

% Bullet list item, two lines.

test(list_item_6):-
    md_bullet_list_item_string("* abc\ndef", "abc\ndef", normal, "").

% Bullet list item, ends with the beginning of new item.

test(list_item_7):-
    md_bullet_list_item_string("* abc\n* def", "abc", normal, "* def").

% Bullet list item, has sublist

test(list_item_8):-
    md_bullet_list_item_string("* abc\n    * def", "abc\n* def", normal, "").

% Bullet list item, has blockquote.

test(list_item_9):-
    md_bullet_list_item_string("* abc\n> def", "abc\n> def", normal, "").

% Bullet list item, has inline HTML.

test(list_item_10):-
    md_bullet_list_item_string("* abc\n<a>def</a>", "abc\n<a>def</a>", normal, "").

% Bullet list item, ends with non-indented line.

test(list_item_11):-
    md_bullet_list_item_string("* abc\ndef\n\nghi", "abc\ndef", normal, "ghi").

:- end_tests(md_list_item).