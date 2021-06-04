function [Output_Erosion,Output_Dilation] = ErosionDilation(inputfile)


%inputfile='blobs.png';

I = imread(inputfile);
SE = [0 1 0; 1 1 1; 0 1 0];
SE = logical(SE);
[rows,columns,dim] = size(I);

for r=1:rows
    for c=1:columns
        Output_Dilation(r,c) = 0;
        Output_Erosion(r,c) = 0;
    end
end

Output_Dilation = logical(Output_Dilation);
Output_Erosion = logical(Output_Erosion);

for r=2:rows-1
    for c=2:columns-1
        if I(r,c) == 0
            Output_Dilation(r,c) = I(r,c);
       else
            if (I(r,c) == SE(2,2) || I(r-1,c) == SE(1,2) || I(r+1,c) == SE(3,2) || I(r,c-1) == SE(2,1) || I(r,c+1) == SE(2,3))
                Output_Dilation(r,c) = 1;
            else
                Output_Dilation(r,c) = 0;
            end
        end
            
    end
end

for r=2:rows-1
    for c=2:columns-1
        if I(r,c) == 0
            Output_Erosion(r,c) = I(r,c);
        else
            if (I(r,c) == SE(2,2) && I(r-1,c) == SE(1,2) && I(r+1,c) == SE(3,2) && I(r,c-1) == SE(2,1) && I(r,c+1) == SE(2,3))
                Output_Erosion(r,c) = 1;
            else
                Output_Erosion(r,c) = 0;
            end
        end
            
    end
end

imwrite(Output_Erosion,'Output_Erosion.png');
imwrite(Output_Dilation,'Output_Dilation.png');
