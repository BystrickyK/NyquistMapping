function [] = plotAnimate(path_s, path_F)
 
%     path_s = complex(real(path_s), imag(path_s));
%     path_F = complex(real(path_F), imag(path_F));
    
    subplot(121);
    line_s = animatedline;
        blue = [0 0.4470 0.7410];
    line_s.Color = blue;
    line_s.LineWidth = 2;
    
    subplot(122);
    line_F = animatedline;
        orange = [0.8500, 0.3250, 0.0980];
    line_F.Color = orange;
    line_F.LineWidth = 2;
    
    for i = 1:length(path_s)
       
        %% s plane
        subplot(121)
        point_s = complex(real(path_s(i)), imag(path_s(i)));
        addpoints(line_s, real(point_s), imag(point_s))
        arrow_scale = 0;
        if(mod(i,150)==0)
            p1 = [real(path_s(i-1)) imag(path_s(i-1))]';
            p2 = [real(path_s(i)) imag(path_s(i))]';
%             arrow_scale = norm(p2-p1, 2) * 100;
%             if (arrow_scale > 180)
%                 arrow_scale = 180;
%             end
            arrowh([p1(1) p2(1)], [p1(2) p2(2)], blue, 180);
        end
        
        try
            rate1 = 0.002/norm(path_s(i)-path_s(i+1));
            xlim([ real(point_s)-1/rate1 real(point_s)+1/rate1])
            ylim([ imag(point_s)-1/rate1 imag(point_s)+1/rate1])
        end
        
        %% F plane
        subplot(122)
%         point_F = complex(real(path_F(i)), imag(path_F(i)));
        point_F = path_F(i);
        addpoints(line_F, real(point_F), imag(point_F));
        
        if(mod(i,150)==0)
            p1 = [real(path_F(i-1)) imag(path_F(i-1))]';
            p2 = [real(path_F(i)) imag(path_F(i))]';
%             arrow_scale = norm(p2-p1, 2)*100;
%             if (arrow_scale > 180)
%                 arrow_scale = 180;
%             end
            arrowh([p1(1) p2(1)], [p1(2) p2(2)], orange, 180);
        end
        
        try
            rate2 = 0.02/norm(path_F(i)-path_F(i+5));
            xlim([ real(point_F)-1/rate2 real(point_F)+1/rate2])
            ylim([ imag(point_F)-1/rate2 imag(point_F)+1/rate2])
        end

        
        %%
    drawnow
    end
            
        