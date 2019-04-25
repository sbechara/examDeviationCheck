% examDeviationCheck.m - Script to flag potential students for Exam
%                        Replacement
%
% Created on: 19 April 2018
% By: Samuel Bechara, PhD
%
Description:
  This script is intended to highlight students who may have had a single
  bad test. Use of this script and the decisions that arise from using it
  are at the discretion of Dr. Bechara. There are no guarantees that if
  you are flagged that you will get an exam grade change. Flagged means
  Dr. Bechara will consider your homework scores, participation,
  discussion posts. If it appears considerable effort has been made in
  these areas, Dr. Bechara MAY consider to replace the lowest exam score
  with the average of the other three.

Filter Explanations
  First Filter:
      Filter out students that have two D's or F's or have one zero
  Second Filter:
      For all other students, "drop" their lowest score and calculate the
      std and mean of the other three exams. If they are tightly bunched,
      average to a 89 or better, AND the student doesn't already have an
      A average, flag for checkup.
% ---------------------------------------------------------------------- %

clear
clc
close all

% Need to update this to work with final grade book. For now, have a few
% sample grades in a matrix (as they would come from canvas)

gradeExample = [92 93 65 93 %     1) should be flagged
                82 83 65 83 %     2) worth a closer look
                72 93 65 82 %     3) shouldn't be flagged
                0 94 95 94  %     4) shouldn't be flagged
                50 50 95 95 %     5) shouldn't be flagged
                50 75 96 96 %     6) worth a closer look
                94 92 91 94 %     7) shouldn't be flagged
                84 82 79 85 %     8) shouldn't be flagged
                71 70 65 95 %     9) shouldn't be flagged
                110 100 83 94; % 10) shouldn't be flagged
                89 91 80 90]; %  11) should be flagged
                
% sorts the grades lo-hi and keeps data in rows. 2 is so it sorts 2nd dimension
gradeExample = sort(gradeExample,2);

% loop through each row (cooresponds to student grades) and flag when
% appropriate
for i = 1:length(gradeExample)
    
    % First filter
    if gradeExample(i,2) > 60 && gradeExample(i,1) ~= 0
        
        % after first filter "drop" lowest exam score and calculate stats
        studentStd = std(gradeExample(i,2:end));
        studentAvg = mean(gradeExample(i,2:end));
        
        % Second filter
        if studentStd <= 1 || studentAvg >= 89 ...
                                            && mean(gradeExample(i,:))<=90
            fprintf('Need to check student number %i\n',i);
        end
    end
end