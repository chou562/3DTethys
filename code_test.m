%pour éviter les bugs et tout réinitialiser
close all
clear variables
load count.dat

%%
%ouverture des fichiers un par un, puis les met dans une cellule
numfiles = 25;
mydata = cell(1, numfiles);

for k = 1:numfiles
  test = sprintf('C:/Users/giaco/OneDrive/stagiare/yasmine/TS/12V/data%d.txt',k);
  mydata{k} = importdata(test);
end

%%
%ce code prend les 25 cellules individuellement et en fais 25 tableaux
for i = 1:numfiles
    % Convertir chaque cellule en tableau
    eval(sprintf('allData%d = array2table(mydata{1,%d});', i, i));

    % Définir les noms des colonnes pour chaque tableau
    eval(sprintf('allData%d = array2table(mydata{1,%d},"VariableNames", ["Ton","Toff", "t", "V", "Tw", "Ta","Ths", "A"]);', i, i));
    
    % Diviser les colonnes du tableau
    %eval(sprintf('truc%d = splitvars(allData%d);', i, i));
end 

%%
% Trouve les valeurs  de Ton, Toff, les valeurs minimales et maximales et moyenne Tw pour chaque allData et les stocke dans le tableau
for m = 1:numfiles
    eval(sprintf('Ton(%d) = min(allData%d.Ton);', m, m));
    eval(sprintf('Toff(%d) = min(allData%d.Toff);', m, m));
    eval(sprintf('Twmin(%d) = min(allData%d.Tw);',  m, m));
    eval(sprintf('Twmax(%d) = max(allData%d.Tw);',  m, m));
    eval(sprintf('Twmoy(%d) = mean(allData%d.Tw);',  m, m));
end
Ton = reshape(Ton,[],1);
Toff = reshape(Toff,[],1);
Twmin = reshape(Twmin,[],1);
Twmax = reshape(Twmax,[],1);
Twmoy = reshape(Twmoy,[],1);

%%
% Convertir les résultats en tableau pour une meilleure lisibilité
tableauMin = table(Twmin,Ton,Toff);
tableauMax = table(Twmax,Ton,Toff);
tableauMoy = table(Twmoy,Ton,Toff);

%%
%creation des courbes
nb = 3;
courbe1 = plot3(tableauMin,"Toff","Ton","Twmin");
courbe2 = plot3(tableauMax,"Toff","Ton","Twmax");
courbe3 = plot3(tableauMoy,"Toff","Ton","Twmoy");

for f = 1:nb
    % Convertir chaque cellule en tableau
    eval(sprintf('courbe%d.Marker = "o";', f));
    eval(sprintf('courbe%d.LineStyle = ":";', f));
    eval(sprintf('courbe%d.Color = "red";', f));
end

grid on;
%%
%creation de plusieurs courbes dans 1 plot
[X,Y,Z] = Ton; Toff; Twmin;
subplot(2,2,1);mesh(X);title('X');
subplot(2,2,2);mesh(Y);title('Y');
subplot(2,2,3);mesh(Y);title('Z');
subplot(2,2,4);mesh(Y);title('XYZ');