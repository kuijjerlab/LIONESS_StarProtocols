addpath('./Tools/DrosteEffect-BrewerMap-5b84f95/');
addpath('./Tools/violin/')

figtag='./Figures/LIONESS';

fid=fopen('./Data/yeast_coexp_net.txt', 'r');
headings=fgetl(fid); headings=strsplit(headings, '\t'); frewind(fid);
NumSamples=length(headings)-2;
LData=textscan(fid, ['%s%s', repmat('%f', 1, NumSamples)], 'delimiter', '\t', 'headerlines', 1);
fclose(fid);
G1=LData{1}; G2=LData{2};
AllGene=unique([G1; G2]);
LData=cat(2, LData{3:end});

time_measurements=0:5:120;
time_measurements=time_measurements([1:21, 23:25]);
time_measurements=[time_measurements, time_measurements];
XLabs=cell(length(time_measurements),1);
for(cnt=1:24)
        XLabs{cnt}=[num2str(time_measurements(cnt)), 'm'];% - R1'];
end
for(cnt=25:48)
        XLabs{cnt}=[num2str(time_measurements(cnt)), 'm'];% - R2'];
end
D=pdist(LData', 'spearman');
Z=linkage(D, 'complete');
[H,T,idx2]=dendrogram(Z,0,'Orientation', 'top', 'labels', '');
set(H, 'linewidth', 2, 'color', 'k');
set(gca, 'FontSize', 6, 'ticklength', [0,0]);
axis off;
if(length(figtag))
	locname=[figtag, '_PearsonDedrogram'];
	set(gcf, 'PaperSize', [16,1], 'PaperPosition', [0,0,16,1]);
	print(gcf, [locname, '.png'],'-dpng', '-painters');
	print(gcf, [locname, '.pdf'],'-dpdf', '-painters');
else
	keyboard
end

[~,idx1]=sort(mean(LData,2), 'descend');
figure(2), imagesc(LData(idx1,idx2), [-3,3])
set(gca', 'xticklabel', '', 'yticklabel', '', 'ticklength', [0,0], 'linewidth', 2);
colorbar('FontSize', 16)
% xlabel('Single Sample Networks', 'FontSize', 20)
% ylabel('Edges (mean weight\rightarrow)', 'FontSize', 20);
cmap=brewermap(64, 'RdYlBu'); cmap=cmap(end:-1:1,:);
colormap(cmap);
if(length(figtag))
	locname=[figtag, '_PearsonData'];
	set(gcf, 'PaperSize', [16,4], 'PaperPosition', [0,0,16,4]);
	print(gcf, [locname, '.png'],'-dpng', '-painters');
	print(gcf, [locname, '.pdf'],'-dpdf', '-painters');
else
	keyboard
end

fid=fopen('./Data/YeastCCData_Expression.txt', 'r');
ExpData=textscan(fid, ['%s', repmat('%f', 1, NumSamples)], 'delimiter', '\t');
fclose(fid);
EG=ExpData{1};
ExpData=cat(2, ExpData{2:end});

[~,ridx]=ismember(AllGene, EG);
EG=EG(ridx(ridx>0));
ExpData=ExpData(ridx(ridx>0), :);
CoExp=corr(ExpData');
uCoExp=CoExp(triu(ones(size(CoExp,1)),1)>0);
bins=-55:.1:55;
orgdist=hist(uCoExp, bins);
figure(3), plot(bins, orgdist/sum(orgdist), 'k-', 'linewidth', 5);
hold on
ldistmu=hist(mean(LData,2), bins);
plot(bins, ldistmu/sum(ldistmu), ':', 'linewidth', 5, 'color', [0.75, 0.75, 0.75]);
ldist=hist(LData(:), bins);
plot(bins, ldist/sum(ldist), 'r:', 'linewidth', 5);
hold off
set(gca, 'xlim', [-3,3], 'box', 'off', 'linewidth', 2, 'FontSize', 20, 'ylim', [0,0.15], 'ytick', 0:.05:0.15)
xlabel('Edge Weight', 'FontSize', 28);
ylabel('Frequency', 'FontSize', 28)
legend({'Aggregate', 'LIONESS Networks (mean)', 'LIONESS Networks (all)'}, 'Location', 'Northeast', 'Fontsize', 12);
if(length(figtag))
	locname=[figtag, '_PearsonEdgeDist'];
	set(gcf, 'PaperSize', [8,6], 'PaperPosition', [0,0,8,6]);
	print(gcf, [locname, '.png'],'-dpng', '-painters');
	print(gcf, [locname, '.pdf'],'-dpdf', '-painters');
else
	keyboard
end

figure(4), violin2(LData(:,idx2), 'facecolor', [0.25,0.25,0.25], 'edgecolor', '')
set(gca, 'ylim', [-6.25,6.25], 'xtick', 1:1:48, 'xticklabel', XLabs(idx2), 'XTickLabelRotation', 90, 'FontSize', 16, 'ytick', [-6:3:6]);
ylabel('Edge Weight', 'FontSize', 20)
if(length(figtag))
	locname=[figtag, '_PearsonEdgeViolins'];
	set(gcf, 'PaperSize', [16,4], 'PaperPosition', [0,0,16,4]);
	print(gcf, [locname, '.png'],'-dpng', '-painters');
	print(gcf, [locname, '.pdf'],'-dpdf', '-painters');
else
	keyboard
end
