function set_menucount( hOBject, eventdata, num )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global new_classcount new_setcount

menu_string = get(get(hOBject, 'Parent'), 'Label');
switch menu_string
    case 'Display Class'
        new_classcount = num;
    case 'Set Start'
        new_setcount = num;
end

end

