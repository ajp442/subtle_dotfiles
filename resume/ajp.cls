\ProvidesClass{ajp}[2022/02/08 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%----------------------------------------------------------------------------------------
%	 REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[sfdefault]{ClearSans}
\RequirePackage{parskip} % Need this to make it look nice.
\usepackage{fontawesome} % This is for the birthday cake icons and such.
\usepackage{twemojis} % This is for the twitter-style emojis.
\usetikzlibrary{positioning,calc}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%----------------------------------------------------------------------------------------
%	 COLOURS
%----------------------------------------------------------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}

%----------------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

%\renewcommand{\bfseries}{\color{gray}} % Make \textbf produce coloured text instead

\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation

%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

%\setlength{\TPHorizModule}{1cm} % Left margin

\newlength\imagewidth{}
\newlength\imagescale{}
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{%
	\setlength\TotalSectionLength{\linewidth}% Set the total line width
	\settowidth{\SectionTitleLength}{\huge #1 }% Calculate the width of the section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
	\addtolength\TotalSectionLength{-2.22221pt}% Modifier to remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{black!80} \huge #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print the title and auto-width rule
}

% Define custom commands for CV info
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline= (char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}}

% Command for printing skill progress bars
\newcommand\skills[1]{ 
	\renewcommand{\skills}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
				\draw[fill=maingray,maingray] (0,\i) rectangle (6,\i+0.4);
				\draw[fill=white,mainblue](0,\i) rectangle (\y,\i+0.4);
				\node [above right] at (0,\i+0.4) {\x};
			}
		\end{tikzpicture}
	}
}

% Command for printing skills text
\newcommand\skillstext[1]{ 
	\renewcommand{\skillstext}{
		\begin{flushleft}
			\foreach{} [count=\i] \x/\y in {#1}{%
				\x$ \star $\y
			}
		\end{flushleft}
	}
}


%----------------------------------------------------------------------------------------
%	 SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\makeprofile}{%
	\begin{tikzpicture}[remember picture,overlay]
   		\node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
	\end{tikzpicture}

	%------------------------------------------------

	\begin{textblock}{6} (0.5, 0.2)
%			
%		%------------------------------------------------
%		
		\ifthenelse{\equal{\profilepic}{}}{}{%
			\begin{center}
				\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
					\clip (600/2, 567/2) circle (567/2);
					\node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
				\end{tikzpicture}
			\end{center}
		}
%
%		%------------------------------------------------
%
		{\Huge\color{mainblue}\cvname}
%
%		%------------------------------------------------
%
		{\Large\color{black!80}\cvjobtitle}\\
		\\
%
%		%------------------------------------------------
%
		\renewcommand{\arraystretch}{1.6}
		\begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
			\ifthenelse{\equal{\cvdate}{}}{}{\textsc{\normalsize\icon{\faBirthdayCake}} & \cvdate\\}
			\ifthenelse{\equal{\cvaddress}{}}{}{\textsc{\Large\icon{\faHome}} & \cvaddress\\}
			\ifthenelse{\equal{\cvnumberphone}{}}{}{\textsc{\Large\icon{\Telefon}} & \cvnumberphone\\}
			\ifthenelse{\equal{\cvsite}{}}{}{\textsc{\Large\icon{\Mundus}} & \cvsite\\}
			\ifthenelse{\equal{\cvmail}{}}{}{\textsc{\large\icon{@}} & \href{mailto:\cvmail}{\cvmail}}
		\end{tabular}
%
%		%------------------------------------------------
%		
		\ifthenelse{\equal{\aboutme}{}}{}{%
			\profilesection{About me}
			\begin{flushleft}
				\aboutme%
			\end{flushleft}
		}
%
%		%------------------------------------------------
%
		\profilesection{Skills}

		\skills{}
		\skillstext{}
		\scriptsize
		(*)[The skill scale is from 0 (Fundamental Awareness) to 6 (Expert).]
%			
%		%------------------------------------------------
%			
	\end{textblock}
}

%----------------------------------------------------------------------------------------
%	 COLOURED SECTION TITLE BOX
%----------------------------------------------------------------------------------------

% Command to create the rounded boxes around the first three letters of section titles
\newcommand*\round[1]{%
	\tikz[baseline= (char.base)]\node[rectangle, rounded corners, fill=mainblue, text=white] (char){#1};%
}

\renewcommand{\section}[1]{%
	{%
		\Large\round{#1}
	}
}

%----------------------------------------------------------------------------------------
%	  SUBSECTION
%----------------------------------------------------------------------------------------

\renewcommand{\subsection}[3][]{%
	\par%\vspace{.5\parskip}
	{%
		\Large\color{mainblue}{#3} \hfill\large\color{gray}{#1}\hfill\color{maingray}\Large{#2}
		\hrule{}
	}
	\par\vspace{.25\parskip}%
}


%----------------------------------------------------------------------------------------
%	 RESUME ITEM
%----------------------------------------------------------------------------------------

\newlength{\ajppad}
\newlength{\ajpparwidth}

\usepackage{changepage}
%\usepackage{mdframed}
\usepackage{multicol}
\usepackage[framemethod=TikZ]{mdframed}
\usepackage{tcolorbox}
\newcommand{\twentyitem}[3]{%
	{\color{mainblue}#2}\hfill{\color{maingray}#1}\\
	\hfill\begin{minipage}{\dimexpr\textwidth}
	\setlength{\leftskip}{1em}
	#3

	\xdef\tpd{\the\prevdepth}
	\end{minipage}
	\par\vspace{.25\parskip}%
}


%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

%\RequirePackage[left=0.1cm,top=0.0cm,right=0.1cm,bottom=0.1cm,nohead,nofoot]{geometry}
\RequirePackage[left=\tabcolsep,top=0.0cm,right=\tabcolsep,bottom=\tabcolsep,nohead,nofoot]{geometry}
%\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry} 

\RequirePackage{hyperref}
