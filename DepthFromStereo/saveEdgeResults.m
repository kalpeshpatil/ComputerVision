

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depth1NCC_edged))); title('NCC');colormap bone;
saveas(fig,'results/edging/depth1NCC_edged','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depth1SAD_edged))); title('SAD');colormap bone;
saveas(fig,'results/edging/depth1SAD_edged','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depth1SSD_edged))); title('SSD');colormap bone;
saveas(fig,'results/edging/depth1SSD_edged','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depthMultiNCC_edged))); title('NCC_Multioccular');colormap bone;
saveas(fig,'results/edging/depthMultiNCC_edged','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depthMultiSAD_edged))); title('SAD_Multioccular');colormap bone;
saveas(fig,'results/edging/depthMultiSAD_edged','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depthMultiSSD_edged))); title('SSD_Multioccular');colormap bone;
saveas(fig,'results/edging/depthMultiSSD_edged','jpg');
close(fig);