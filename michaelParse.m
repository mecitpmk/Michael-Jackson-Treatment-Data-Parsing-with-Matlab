clc;clear all; close all;

fid = fopen('michael.mlc');


data_number = 1;
while (~feof(fid))
    line = fgetl(fid);
    if (line == "")
        continue
    end
    [words,value] = splitWords(line);
    if (words == "File Rev")
        patient.FileRev = value;
    elseif (words == "Treatment")
        patient.Treatment = value;
    elseif (words == "Last Name")
        patient.LastName = value;
    elseif (words == "First Name")
        patient.FirstName = value;
    elseif (words == "Patient ID")
        patient.ID = str2double(value);
    elseif (words == "Number of Fields")
        patient.NumberofFields = str2double(value);
    elseif (words == "Model")
        patient.Model = value;
    elseif (words == "Tolerance")
        patient.Tolerance = str2double(value);
    elseif (words == "Field")
        patient.data(data_number).field = value;
        for k = 1:4
            line = fgetl(fid);
            [words,value] = splitWords(line);
            if (words == "Index")
                patient.data(data_number).index = str2double(value);
            elseif (words == "Carriage Group")
                patient.data(data_number).group = str2double(value);
            elseif (words == "Operator")
                patient.data(data_number).operator = value;
            elseif (words == "Collimator")
                patient.data(data_number).collimator = str2double(value);
            end
        end
        for i = 1:2
            for lft = 1:60
                line = fgetl(fid);
                [words,value] = splitWords(line);
                if (i == 1)
                    patient.data(data_number).leaf.a(lft) = str2double(value);
                else
                    patient.data(data_number).leaf.b(lft) = str2double(value);
                end
            end
        end
        for nsm =  1:3
            line = fgetl(fid);
            [words,value] = splitWords(line);
            patient.data(data_number).note = str2double(value);
            patient.data(data_number).shape = str2double(value);
            patient.data(data_number).magnification = str2double(value);
        end
        data_number = data_number +1;
    end
end
