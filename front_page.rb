# coding: utf-8
# Fontion to write client's and enterprise's contact
def write_suivi_doc(fd_front_page, intro_tab, intro_tab_read)
  fd_front_page.write("\\section*{\\textcolor{pinkpd}{Suivi du document}}\n\\vspace{0.6cm}\n\n");
  fd_front_page.write("{\\noindent \\large{Référence : " + intro_tab[4] + "\\\\[0.6cm]\n    Version : " + intro_tab[2] + "\\\\[0.6cm]\n    Etat : " + intro_tab[5] + "}}\\\\[2cm]\n\n");

  fd_front_page.write("{\\Large \\textbf{Destinataires} }\\\\\n\n");

  i = 2;
  n = 0;
  tmp = [];
  clients = []
  consultants = []
  b = 0;
  d = 0;
  
# Save clients and consultants in two arrays in order to write them later
  while (i != intro_tab_read.length)
    tmp[n] = regroup_with_coma(intro_tab_read[i]);
    if (tmp[n].length > 3)
      consultants[b] = tmp[n][3..5];
      b += 1;
    end
    if (tmp[n][2].include? "@enterprise.com")
      consultants[b] = tmp[n][0..2];
      b += 1;
    else
      clients[d] = tmp[n][0..2];
      d += 1;
    end
    n += 1;
    i += 1;
  end

# Clients info tab
  fd_front_page.write("{ \\rowcolors{1}{gray!10}{bcarray}\n  {\\renewcommand{\\arraystretch}{2}\n    { \\centering\n\n      ")

  fd_front_page.write("\\begin{tabular}{m{5cm}m{5cm}m{6cm}}\n        ");
  fd_front_page.write("\\rowcolor{bharray} {\\color{white}\\textbf{Nom}} & {\\color{white} \\textbf{Entité}} & {\\color{white} \\textbf{E-mail}}\\\\\n");
  
  n = 0;
  while (n != clients.length)
    fd_front_page.write("        " + clients[n][0] + " & " + clients[n][1] + " & " + clients[n][2] + "\\\\\n");
    n += 1;
  end
  fd_front_page.write("    \\end{tabular} }\n\n");
  fd_front_page.write("    \\vspace{2cm}\n\n    ");

# Consultants info tab
  fd_front_page.write("{\\Large \\textbf{Contacts Enterprise} }\\\\ \\par\n    ");
  fd_front_page.write("{ \\centering\n\n      ");

  fd_front_page.write("\\begin{tabular}{m{5cm}m{5cm}m{6cm}}\n        ");
  fd_front_page.write("\\rowcolor{bharray} {\\color{white}\\textbf{Nom}} & {\\color{white} \\textbf{Fonction}} & {\\color{white} \\textbf{Détails}}\\\\\n");

  n = 0;
  while (n != consultants.length)
    fd_front_page.write("        " + consultants[n][0] + " & " + consultants[n][1] + " & " + consultants[n][2] + "\\\\\n");
    n += 1;
  end
  fd_front_page.write("\\end{tabular} }}}");
end

# Fonction to write the front page in front_page.tex
def write_front_page(intro_tab, intro_tab_read)
  fd_front_page = open("front_page.tex", 'w');

  fd_front_page.write("\\begin{titlepage}\n  \\begin{center}\n\n    ");
  fd_front_page.write("\\begin{figure}[t]\n      \\begin{minipage}[b]{0.55\\linewidth}\n");
  fd_front_page.write("        \\centering \\includegraphics[width=10cm, left]{image/logo_devo}\n      \\end{minipage}\n      ");
  fd_front_page.write("\\begin{minipage}[b]{0.48\\linewidth}\n        \\centering \\includegraphics[width=12cm, right]{image/innovativetechnologyconsultingforbusiness}\n      \\end{minipage}\n    \\end{figure}\n\n    ");

  fd_front_page.write("\\includegraphics[width=\\textwidth]{image/bandeau_titre}\\\\[2cm]\n\n    ");

  fd_front_page.write("{ \\huge \\bfseries " + intro_tab[0] + "\\\\[0.3cm] }\n    ");
  fd_front_page.write("\\textsc{\\huge " + intro_tab[1] + "}\n");
  fd_front_page.write("  \\end{center}\n\n  \\vspace{4cm}\n  ");
  fd_front_page.write("\\Large{Version " + intro_tab[2] + "}\\par\n        {");
  fd_front_page.write(intro_tab[3] + "}\n");
  fd_front_page.write("\\end{titlepage}\n\n\n");
  fd_front_page.write("\\newgeometry{hmargin=2.5cm,vmargin=1.5cm,bottom=5cm}\n.\\vspace{0.5cm}\n");

  fd_front_page.write("\\fancyfoot[C]{"+ intro_tab[3] + "}\n\n");
  write_suivi_doc(fd_front_page, intro_tab, intro_tab_read);
  fd_front_page.close();
end
