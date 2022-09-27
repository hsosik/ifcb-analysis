% function [ classcount, binlist, class2use ] = countcells_manual_onetimeseries( bin )
function [ data ] = bin_classifications( bin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%[ classcount, binlist, class2use ] = countcells_manual_oneclass_onetimeseries('Ceratium', 'mvco')
    %conn = getDBConnection_readonly();
    conn = getDBConnection();
    if ~isopen(conn)
        fprintf('ERROR: No connection, are your credentials correct?\n');
        return;
    end
    
    query = fileread('bin_classifications.sql');
    query = sprintf(query, bin);
    % query = 'select count(*) from classify_user_power ';
    
    cursor = exec(conn, query);
    cursor = fetch(cursor);
    data = cursor.Data;
    disp(cursor);
    
    close(conn);
end

