\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{assignments}[2023/08/16 Assignment LaTeX class]

\frenchspacing
%% load article as base
\LoadClass[12pt]{article}
%%%%%% end article
%%%%%% Math stuff
\RequirePackage{siunitx}
\RequirePackage{gensymb}
%%%%%%
%%%%%% Document Spacing
\RequirePackage{setspace}
\setstretch{1.5}
%%%%%%
%% pdfpages
\RequirePackage{pdfpages}
%%%%%
%% set geometry
\RequirePackage[letterpaper, margin=1in]{geometry}
%%%%%%
\global\let\@captionvalue\empty
%% quote code and table styling
\RequirePackage[most]{tcolorbox}
\RequirePackage{etoolbox}
\RequirePackage{environ}
\RequirePackage{minted}
\RequirePackage{adjustbox}
\AtBeginEnvironment{quote}{\itshape}% chktex 6
\let\tabularold\tabular{}
\let\endtabularold\endtabular{}
\RenewEnviron{tabular}[1]{\adjustbox{max width=\columnwidth,center}{
		\ifthenelse{\equal{\empty}{\@captionvalue}}{
			\tcbox[left=0mm, right=0mm, top=0mm, bottom=0mm]{
				\tabularold{#1}\BODY\endtabularold}
		}{
			\tcbox[left=0mm, right=0mm, top=0mm, bottom=0mm, title=\@captionvalue, center title]{
				\tabularold{#1}\BODY\endtabularold}
			\global\let\@captionvalue\empty
		}
	}}
\BeforeBeginEnvironment{minted}{
\ifthenelse{\equal{\empty}{\@captionvalue}}{
	\begin{tcolorbox}[enhanced, breakable, skin first=enhanced, skin middle=enhanced, skin last=enhanced]}{
	\begin{tcolorbox}[enhanced, breakable, skin first=enhanced, skin middle=enhanced, skin last=enhanced, title=\@captionvalue]}{
		}
		}%
		\AfterEndEnvironment{minted}{%
	\end{tcolorbox}
	\global\let\@captionvalue\empty
}
\BeforeBeginEnvironment{verbatim}{\begin{tcolorbox}[enhanced, breakable, skin first=enhanced, skin middle=enhanced, skin last=enhanced]}%
		\AfterEndEnvironment{verbatim}{\end{tcolorbox}}
%%%%%




%% Hyperlinks
\RequirePackage{hyperref}
\hypersetup{
	colorlinks = true,
	urlcolor=blue,
	linkcolor=black,
	citecolor = black
}
%%%%

%% set mono font
\RequirePackage{fontspec}
\setmonofont[Renderer=Harfbuzz]{JetBrainsMono Nerd Font Mono}
%%%%%%%

%% start fancyhdr
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead[C]{}
\fancyhead[L]{\@title}
\fancyhead[R]{\@date}
\fancyfoot[C]{}
\fancyfoot[L]{\@author}
\fancyfoot[R]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

\fancypagestyle{firstpage}{%
	\renewcommand{\headrulewidth}{0.0pt}
	\fancyhf{}
	\fancyfoot[C]{}
	\fancyfoot[L]{\@author}
	\fancyfoot[R]{\thepage}
}
%%%%% end fancyhdr



%%% Hack to enable \tabular to work correctly
\renewcommand\maketitle{
\par
\begingroup
\renewcommand\thefootnote{\@fnsymbol\c@footnote}%
\def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
\long\def\@makefntext##1{\parindent 1em\noindent
\hb@xt@1.8em{%
\hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
\global\@topnum\z@   % Prevents figures from going at top of page.
\@maketitle
\thispagestyle{firstpage}\@thanks
\endgroup
\setcounter{footnote}{0}%
\global\let\thanks\relax
\global\let\maketitle\relax
\global\let\@maketitle\relax
\global\let\@thanks\@empty
%\global\let\@author\@empty
%\global\let\@date\@empty
%\global\let\@title\@empty
\global\let\title\relax
\global\let\author\relax
\global\let\date\relax
\global\let\and\relax
}
\def\@maketitle{%
	\newpage
	\null{}
	\vskip 2em%
	\begin{center}%
		\let\footnote\thanks{}
		{\LARGE \@title \par}%
		\vskip 1.5em%
			{\large
				\lineskip .5em%
				\begin{tabularold}[t]{c}%
					\@author
				\end{tabularold}%
				\par}%
		\vskip 1em%
			{\large \@date}%
	\end{center}%
	\par
	\vskip 1.5em}

%%%%% Captions
%\RequirePackage{caption}
%\DeclareCaptionFormat{tcboxcaption}{\gdef\@captionvalue{#1#2: #3} }
%\captionsetup[table]{format=tcboxcaption, position=top}
%\captionsetup[listing]{format=tcboxcaption, position=top}
\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname ext@#1\endcsname}{#1}{%
		\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}
	\begingroup \@parboxrestore \normalsize
	\@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
	\endgroup}
\long\def\@makecaption#1#2{%
	\vskip\abovecaptionskip{}
	\ifthenelse{\equal{table}{\@currenvir} \OR \equal{listing}{\@currenvir}}{
		\gdef\@captionvalue{#1: #2}}{
		\sbox\@tempboxa{#1: #2 }%
		\ifdim \wd\@tempboxa >\hsize
			#1: #2 \par
		\else
			\global \@minipagefalse
			\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
		\fi
		\vskip\belowcaptionskip
	}
}
%%%%%

%% Figure/table placement (Exactly where my link is, no floating for me)
\RequirePackage{float}
\restylefloat*{listing}

\def\fps@figure{H}
\def\fps@table{H}
%%%%%
