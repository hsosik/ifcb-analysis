function [ ] = change_config( hOBj, eventdata, t )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global MCconfig

prompt = {'Set size for image display' 'Image resizing factor (1 = none)'};
defaultanswer={num2str(MCconfig.setsize),num2str(MCconfig.imresize_factor)};
user_input = inputdlg(prompt,'Configure', 1, defaultanswer);

[val status] = str2num(user_input{1});
if status && rem(val,1) ~= 0, status = 0; end
while ~status
    uiwait(msgbox(['Set size must be an integer']))
    user_input(1) = defaultanswer(1);
    user_input = inputdlg(prompt,'Configure', 1, user_input);
    [val status] = str2num(user_input{1});
    if status && rem(val,1) ~= 0, status = 0; end
end
MCconfig.setsize = str2num(user_input{1});

[val status] = str2num(user_input{2});
while ~status
    uiwait(msgbox(['Resize factor must be a number']))
    user_input(2) = defaultanswer(2);
    user_input = inputdlg(prompt,'Configure', 1, user_input);
    [val status] = str2num(user_input{2});
end
MCconfig.imresize_factor = str2num(user_input{2});



end

