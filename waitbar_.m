%==================加入进度条===========================
function waitbar_  %进度条
steps=50;
hwait=waitbar(0,'请等待>>>>>>>>');
step=steps/100;
for k=1:steps
    if steps-k<=5
        waitbar(k/steps,hwait,'即将完成');
        pause(0.05);
    else
        PerStr=fix(k/step);
        str=['识别中',num2str(PerStr),'%'];
        waitbar(k/steps,hwait,str);
        pause(0.05);
    end
end
close(hwait);