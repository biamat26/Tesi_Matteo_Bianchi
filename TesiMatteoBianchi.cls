
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesPackage{TesiMatteoBianchi}[2026/10/22 v2.0 Tesi - Matteo Bianchi]

\LoadClass[a4paper,11pt,oneside,italian]{memoir}

% Si utilizza la sillabazione italiana
\RequirePackage[italian]{babel}
% Load graphicx
\RequirePackage{graphicx}
% Line spacing
\RequirePackage{setspace}

% pacchetti per i font
\usepackage[T1]{fontenc}
% interlinea
\linespread{1.4}
% margini (la dimensione del blocco di testo viene regolata di conseguenza)
\setlrmarginsandblock{3.5cm}{3cm}{*}
% profondità dell'indice (settato per stampare fino alle sottosezioni)
\setcounter{tocdepth}{2}
% numera parti, capitoli, sezioni, sottosezioni e sotto-sottosezioni
\maxsecnumdepth{subsubsection}
\setsecnumdepth{subsubsection}

% header personalizzati
\let\footruleskip\relax % for compatibility of memoir and fancyhdr
\let\rm\rmfamily        % for compatibility of memoir and blindtext (demo only)
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\addtolength{\headheight}{14pt}
\fancyhead[R]{\textbf{\thepage}}
\fancyhead[L]{\textbf{\leftmark}}

\usepackage{adjustbox}

% I comandi interni con ``@'' richiedono che il carattere sia trattato
% come lettera anche quando questa classe viene caricata da un documento.
\makeatletter
\newcommand{\@annoAccademico}{2022/2023}
\newcommand{\annoAccademico}[1]{\renewcommand{\@annoAccademico}{#1}}
% Autore 
\newcommand{\@autore}{Cognome Nome}
\newcommand{\autore}[1]{\renewcommand{\@autore}{#1}}
% Titolo
\newcommand{\@titolo}{Titolo della tesi}
\newcommand{\titolo}[1]{\renewcommand{\@titolo}{#1}}
% Matricola 
\newcommand{\@matricola}{000000}
\newcommand{\matricola}[1]{\renewcommand{\@matricola}{#1}}
% Relatore (Titolo Nome Cognome, es: Prof. Pippo Caruso)
\newcommand{\@relatore}{Prof. Nome Cognome}
\newcommand{\relatore}[1]{\renewcommand{\@relatore}{#1}}
% Correlatore (Titolo Nome Cognome, es: Dott. Pippo Caruso)
\newcommand{\@correlatore}{}
\newcommand{\correlatore}[1]{\renewcommand{\@correlatore}{#1}}
% Dedica
\newcommand{\@dedica}{}
\newcommand{\dedica}[1]{\renewcommand{\@dedica}{#1}}

% Generazione del FRONTESPIZIO
\newcommand{\generaFrontespizio}{
   \thispagestyle{empty}
   \enlargethispage{3cm}
   \begin{center}
      \vspace{10mm}
      {\includegraphics[width=0.4 \linewidth]{figure/uniroma3-logo}} \\
      \vspace{10mm}
      {\Large UNIVERSIT\`A DEGLI STUDI ROMA TRE} \\
      \vspace{5mm}
      {\LARGE Dipartimento di Ingegneria Civile, Informatica\\ e delle Tecnologie Aeronautiche} \\
      {\Large Corso di Laurea in Ingegneria Informatica} \\
      \vspace{15mm}
      {\LARGE Tesi di Laurea} \\
      \vspace{15mm}
      {
         \begin{adjustbox}{minipage=1\textwidth}
            \begin{center}
               \linespread{1} \HUGE \@titolo
            \end{center}
         \end{adjustbox}
      } \\
      %{\HUGE \@titolo} \\
      \vspace{15mm}
      {\large Laureando \\ \textbf{\@autore}} \\
      \vspace{7mm}

        %
% scommenta questo blocco...
%
%      {\large Relatore \\ \textbf{\@relatore}} \\
%
% ... oppure scommenta questo blocco
%
      \begin{tabular}[t]{c  @{\hspace{2.5cm}} c}
        Relatore & Correlatori \\
        \textbf{\@relatore} & \textbf{\begin{tabular}[t]{@{}c@{}}\@correlatore\end{tabular}} \\
      \end{tabular}\par
%
      \vspace*{\fill}
      {\large Anno Accademico \@annoAccademico}
   \end{center}
   \newpage 
}

% Generazione della DEDICA (posizionata ad un terzo della pagina)
\newcommand{\generaDedica}{
   \thispagestyle{empty}
   \null\vspace{\stretch{1}}
   \begin{flushright}
      \emph{{\@dedica}}
   \end{flushright}
   \vspace{\stretch{2}}\null
   \newpage
}
\makeatother

% Comandi riguardanti l'inserimento di capitoli
\newcommand{\ringraziamenti}[1]{\newpage \chapter*{Ringraziamenti} \input{#1}}
\newcommand{\introduzione}[1]{\newpage \chapter{Introduzione} \input{#1}}
\newcommand{\conclusioni}[1]{\newpage \chapter{Conclusioni e sviluppi futuri} \markboth{CONCLUSIONI E SVILUPPI FUTURI}{CONCLUSIONI E SVILUPPI FUTURI} \input{#1}}
\newcommand{\capitolo}[2]{\newpage \chapter{#1}\label{cap:#2}\input{#2}}

% Comandi riguardanti la generazione di indici
\newcommand{\generaIndice}{
	%\fancyhead[L]{\textbf{\rightmark}}
	\newpage
	\tableofcontents
	\clearpage
	%\fancyhead[L]{\textbf{\leftmark}}
}
\newcommand{\generaIndiceTabelle}{\newpage \listoftables}
\newcommand{\generaIndiceFigure}{\newpage \listoffigures}

% Bibliografia in ordine alfabetico
\let \OldBib \bibliography
\renewcommand{\bibliography}[1]{\newpage \markboth{Bibliografia}{Bibliografia} \OldBib{#1}}
\bibliographystyle{alpha}
