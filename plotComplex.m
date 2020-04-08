function N = plotAnimate(path_s, path_F)
 
%     path_s = complex(real(path_s), imag(path_s));
%     path_F = complex(real(path_F), imag(path_F));
    close all
    filename = 'animation.gif';
%     fig = figure('visible','off'); % getframe function for gif creation
%     runs 4x slower if figure is invisible
    fig = figure('visible','on');
    set(fig, 'Position',  [100, 100, 1500, 750])

    ax1 = subplot(121)
    hold on
    grid on
    axis equal
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    title("s plane")
    line_s = animatedline;
    blue = [0 0.4470 0.7410];
    line_s.Color = blue;
    line_s.LineWidth = 2;

    ax2 = subplot(122)
    hold on
    grid on
    axis equal
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    title("L(s) plane")
    line_F = animatedline;
    orange = [0.8500, 0.3250, 0.0980];
    line_F.Color = orange;
    line_F.LineWidth = 2;
          
    point_s = complex(real(path_s(1)), imag(path_s(1)));
    addpoints(line_s, real(point_s), imag(point_s))
    point_F = complex(real(path_F(1)), imag(path_F(1)));        
    addpoints(line_F, real(point_F), imag(point_F));
        
    q = quiver(-1, 0, real(path_F(1))+1, imag(path_F(1)), 1);
    q.LineWidth = 1.5;
    q.Color = 'k';
    q.ShowArrowHead = 'off';
    
    frame = getframe(fig);
    
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
        
    beta = zeros(length(path_s),1);
    beta(1) = atan2(imag(path_F(1)), real(path_F(1))+1);
    
    for i = 2:length(path_s)
       
        %% s plane
        point_s = complex(real(path_s(i)), imag(path_s(i)));
        addpoints(line_s, real(point_s), imag(point_s))
%         if(mod(i,180)==0)
%             p1 = [real(path_s(i-1)) imag(path_s(i-1))]';
%             p2 = [real(path_s(i)) imag(path_s(i))]';
% 
%             arrowh([p1(1) p2(1)], [p1(2) p2(2)], blue, 120);
%         end
        
        try
            rate1 = 0.01/norm(path_s(i)-path_s(i+1));
            xlim(ax1, [ real(point_s)-1/rate1 real(point_s)+1/rate1])
            ylim(ax1, [ imag(point_s)-1/rate1 imag(point_s)+1/rate1])
        end
        
        %% F plane
%         point_F = complex(real(path_F(i)), imag(path_F(i)));
        point_F = path_F(i);
        
        addpoints(line_F, real(point_F), imag(point_F));
%         Dbeta = atan(imag(point_F), real_point(F)) - beta(i-1)
%         beta(i) = beta(i-1) + Dbeta
        set(q,'udata',real(point_F)+1,'vdata',imag(point_F))
        beta(i) = atan2(imag(path_F(i)), real(path_F(i))+1);
%         if(mod(i,180)==0)
%             p1 = [real(path_F(i-1)) imag(path_F(i-1))]';
%             p2 = [real(path_F(i)) imag(path_F(i))]';
%             arrowh([p1(1) p2(1)], [p1(2) p2(2)], orange, 200);
%         end
        N = -unwrap(beta(1:i))/2/pi;
        ax2.Title.String = {"L(s) plane";"Clockwise encirclements N = " + string(N(end))};

%         adaptive zoom
        try
            rate2 = 0.1/norm(path_F(i)-path_F(i+1), 2);
            xlim(ax2, [ real(point_F)-1/rate2 real(point_F)+1/rate2])
            ylim(ax2, [ imag(point_F)-1/rate2 imag(point_F)+1/rate2])
        end

%         ax2.XLimMode = 'auto';
%         ax2.YLimMode = 'auto';
        
        %% 
    drawnow
    if(mod(i,3)==0) %capture every 5th frame
        frame = getframe(fig);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0); 
    end

    
    end
    
    ax1.XLimMode = 'auto';
    ax1.YLimMode = 'auto';
    ax2.XLimMode = 'auto';
    ax2.YLimMode = 'auto';
    
    frame = getframe(fig);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',5); 
    
    N = -unwrap(beta)/2/pi;
            
        