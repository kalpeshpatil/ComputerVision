

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depth1NCC))); title('NCC');colormap bone;
saveas(fig,'results/full_image/depth1NCC','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depth1SAD))); title('SAD');colormap bone;
saveas(fig,'results/full_image/depth1SAD','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depth1SSD))); title('SSD');colormap bone;
saveas(fig,'results/full_image/depth1SSD','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depthMultiNCC))); title('NCC Multioccular');colormap bone;
saveas(fig,'results/full_image/depthMultiNCC','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depthMultiSAD))); title('SAD Multioccular');colormap bone;
saveas(fig,'results/full_image/depthMultiSAD','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray((depthMultiSSD))); title('SSD Multioccular');colormap bone;
saveas(fig,'results/full_image/depthMultiSSD','jpg');
close(fig);