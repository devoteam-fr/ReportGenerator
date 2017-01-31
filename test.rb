# coding: utf-8
load "fcts.rb"
load "front_page.rb"

fd_to_read = open("vulnerabilites.csv", 'r');
i = 0;
tab = [];

# Copy all line (Vulnerabilities) in tab
while (line = fd_to_read.gets)
  tab[i] = line;
  i += 1;
end

# Open intro.csv and create intro.tex
fd_intro_read = open("intro.csv", 'r');
fd = open("intro.tex", 'w');

n = 0;
intro_tab_read = [];
# read from intro.csv and save in intro_tab_read
while (line = fd_intro_read.gets)
  intro_tab_read[n] = line;
  n += 1;
end

intro_tab = regroup_with_coma(intro_tab_read[1]);
# Write the front page and "follow document" page
write_front_page(intro_tab, intro_tab_read);

fd.write("\\subsection{Contexte}\n");
fd.write(intro_tab[12]);
fd.write("\n\n\\subsection{Objet du document}\n");
fd.write(intro_tab[13]);
fd.write("\n\n\\subsection{Déroulement de la mission}\n");
fd.write(intro_tab[14]);

fd_intro_read.close();
fd.close();



fd = open("synthese.tex", 'w')
fd_synth_read = open("synthese.csv", 'r');

j = 0;
synth_tab = [];
good = [];
bad = [];
tmp = [];

# Read into synthese.csv and save lines in synth_tab
while (line = fd_synth_read.gets)
  synth_tab[j] = line;
  j += 1;
end

j = 1;

# Copy Good and Bad points in "good" && "bad" var
while (j != synth_tab.length)
  tmp = regroup_with_coma(synth_tab[j]);
  if (tmp.length == 3)
    good << tmp[1];
    bad << tmp[2];
  elsif (tmp.length == 2)
    good << tmp[0];
    bad << tmp[1];
  else
    bad << tmp[0];
  end
  j += 1;
end

titi = synth_tab[1].split(',');

# Write the synthesis, good and bad points
fd.write("\\color{pinkpd}\\section{\\textcolor{pinkpd}{Synthèse}}\\color{black}\n\n");
fd.write("Les résultats obtenus suite à la réalisation du test d’intrusion sur le périmètre spécifié permettent d’identifier un niveau de sécurité général \\textbf{" + titi[0] + "} : \n\n\\vspace{1cm}\n\n\\includegraphics[width=25pt, height=25pt]{image/positif}Points positifs : \\\n\\begin{itemize}\n");

j = 0;
while (good[j] != nil)
  fd.write("  \\item " + good[j] + "\n");
  j += 1;
end

fd.write("\\end{itemize}\\\n\n\\includegraphics[width=25pt, height=25pt]{image/negatif.png}Points faibles : \\begin{itemize}\n");

j = 0;
while (bad[j] != nil)
  fd.write("  \\item " + bad[j] + "\n");
  j += 1;
end

fd.write("\\end{itemize}\n\n\\newpage\n\n");

# class Vul by criticality
sort_tab = sort_by_criticality(tab);

# Write recap Vul tab in synthese.tex
fd.write("\\subsection{Vulnérabilités classées par criticité avec recommandations associées}\n\n");

fd.write("\\setlength\\LTleft{-2cm}\n");
fd.write("\\begin{longtable}{|m{2cm}|m{2cm}|m{3cm}|m{2.5cm}|m{2cm}|m{3.2cm}|m{3cm}|}\n  \\bhline\n");
fd.write("  \\textbf{N de Vuln.} & \\textbf{Criticité} & \\textbf{Impact} & \\textbf{Difficulté d'exploitation} & \\textbf{N Reco.} & \\textbf{Recommandations} & \\textbf{Composant}\\\\\n  \\bhline\n");

n = 0;
save = [];
tline = [];
while (n != sort_tab.length)
  tline = regroup_with_coma(sort_tab[n]);
  fd.write("  \\center{\\includegraphics[width=35pt, height=60pt]{image/" + tline[3].downcase + ".png}} \\newline \\center{" + tline[1] + "} & \\center{" + tline[3].capitalize + "} & " + tline[4] + " & Niveau de risque" + " & \\center{\\includegraphics[width=35pt, height=60pt]{image/" + tline[11].downcase + ".png}} \\newline \\center{" + tline[9] + "} & " + tline[10] + " & " + tline[7] + "\\\\\n  \\bhline\n");
  n += 1;
end

fd.write("\\end{longtable}\n\n\\newpage\n\n");

fd_synth_read.close();
fd.close();

# Sort vuln for part 3 of the report (vuln details)
tab = regroup_same_type_of_vuln(tab);


fd = open("vulnerabilites.tex", 'w')
n = 1;
tline = []; #str_to_wordtab(tab[n], ',')
save = [];

fd.write("\\color{pinkpd}\\section{\\textcolor{pinkpd}{Recherche de vulnérabilités}}\\color{black}");

# Write all Vuln in vulnerabilites.tex
split_cmp = [];
while (n < tab.length)
  tline = regroup_with_coma(tab[n]);
  if (n > 0)
    split_tab = tab[n].split(',');
    split_cmp = tab[n - 1].split(',');
  end
  if (split_tab[0] != split_cmp[0])
    fd.write("\\subsection{" + tline[0] + "}\n\\vspace{1cm}\n\n");
  end
  fd.write("\\begin{center}\n\\begin{tabular}{m{4cm}m{3cm}m{8cm}}\n  \\bhline\n");
  fd.write("  \\center{\\color{pinkpd}\\huge{\\textbf{" + tline[1] + "}}} & \\color{pinkpd}\\textbf{Description} & \\color{pinkpd}\\textbf{" + tline[2] + "}\\\\\n  \\bhline\n");
  fd.write("  \\center{\\multirow{3}{*}{\\includegraphics{image/" + tline[3].downcase + ".png}}} & \\cellcolor{bcarray}Impact & \\cellcolor{bcarray}" + tline[4] + "\\\\\n  \\cline{2-3}\\\\\n");
  fd.write("  & Exploitation & " + tline[5] + "\\\\\n  \\cline{2-3}\n");
  fd.write("  & \\cellcolor{bcarray}DICT & \\cellcolor{bcarray}" + tline[6] + "\\\\\n  \\cline{2-3}\\\\\n");
  fd.write("  \\center{\\textbf{\\color{pinkpd}" + tline[3].capitalize + "}} & Composant & " + tline[7] + "\\\\\n");
  fd.write("  \\bhline\n\\end{tabular}\\\\\n\\end{center}\n\n");

  i = 0;
  while (i < tline[8].length)
    if (tline[8][i] == '%')
      i += 1;
      fd.write("\\center{\\includegraphics[width=\\textwidth]{");
      while (tline[8][i] != ' ' && i < tline[8].length)
        fd.write(tline[8][i]);
        i += 1;
      end
      fd.write("}}");
    end
    while (tline[8][i] != '%' && i < tline[8].length)
      fd.write(tline[8][i]);
      i += 1;
    end
  end
  fd.write("\\\\\n\n\\begin{center}\n\\begin{tabular}{m{4cm}m{3cm}m{8cm}}\n  \\bhline\n");
  fd.write("  \\center{\\color{pinkpd}\\huge{\\textbf{" + tline[9] + "}}} & \\color{pinkpd}\\textbf{Description} & \\color{pinkpd}\\textbf{" + tline[10] + "}\\\\\n  \\bhline\n");
  fd.write("  \\center{\\multirow{2}{*}{\\includegraphics{image/" + tline[11].downcase + ".png}}} & \\cellcolor{bcarray}Coût & \\cellcolor{bcarray}" + tline[12] + "\\\\\n  \\cline{2-3}\\\\\n");
  fd.write("  & Mise en œuvre & " + tline[13] + "\\\\\n  \\cline{2-3}\n");
  fd.write("  \\vspace{0.8cm}\\center{\\textbf{\\color{pinkpd}" + tline[11].capitalize + "}} & \\cellcolor{bcarray}Composant & \\cellcolor{bcarray}" + tline[14] + "\\\\\n  \\bhline\n\\end{tabular}\\\\\n\\end{center}\n\n");

  fd.write("\\newpage\n\n");
  n += 1;
end

fd_to_read.close()
fd.close()
