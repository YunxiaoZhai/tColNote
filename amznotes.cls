% ------------------------------------------------------------
% amznotes - Alex M Zhang notes
% Credit to David Zhang for the original template
% Source: https://github.com/alexmingzhang/amznotes (adapted in this repository)

% To fix header for unnumbered chapters, do:
% \chapter*{Chapter Title}
% \markboth{Chapter Title}{Chapter Title}

\ProvidesClass{amznotes}
\NeedsTeXFormat{LaTeX2e}
\LoadClass[12pt]{report}


% ------------------------------------------------------------
% PROCESS OPTIONS

\RequirePackage{kvoptions}      % import a library that could process boolean variable
\DeclareBoolOption{math}        % enables thmbox and math macros
\DeclareBoolOption{code}        % enables codebox, amzcode, and \amzinputcode
\DeclareBoolOption{fastcompile} % turns off some features for faster compiling
\ProcessKeyvalOptions{amznotes} % tell kvoptions to assign above boolean variables to class `amznotes`, i.e., a variable like \ifamznotes@math used below

% ------------------------------------------------------------
% LOAD REQUIRED PACKAGES

\RequirePackage[left=0.5in, right=0.5in, top=1in, bottom=0.7in]{geometry}   % set margins
\RequirePackage{fontspec}               % set main font
\RequirePackage[fontset=none, scheme=plain]{ctex} % set Chineese font
\RequirePackage[dvipsnames]{xcolor}     % pretty colors
\RequirePackage{sectsty}                % section style, \sectionfont need this
\RequirePackage{hyperref}               % hyperlinks in pdf viewers; will appear underlined only in pdf viewer
\RequirePackage{fancyhdr}               % fancy headers
\RequirePackage{lastpage}               % "X of Y" footer
\RequirePackage{parskip}                % new line after each paragraph w/o indent
\RequirePackage{setspace}               % 1.5 line spacing
\RequirePackage[explicit]{titlesec}     % chapter styling
\RequirePackage[most]{tcolorbox}        % pretty boxes
\usepackage{fontawesome}                % awesome font
\RequirePackage{ifthen}                 % disable index entries not being used
\RequirePackage{morewrites}             % each box list in the index needs a \write stream; TeX only has 16
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{enumitem}                           % customize itemize spacing
\RequirePackage{xfrac}                              % small fractions
\usepackage{graphicx}                               % in order to set bullet marker shape
\RequirePackage[textsize=scriptsize]{todonotes}     % todo notes
\RequirePackage{tabularx}
\RequirePackage{diagbox}
\usepackage{xparse}
%
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsfonts}
\RequirePackage{mathrsfs}
\RequirePackage{bm}
\usepackage{cancel}


% ------------------------------------------------------------
% BIBILIOGRAPHY SETUP

\RequirePackage[backend=biber,style=authoryear, % biber is character processsor, authoryear is to set sequence as author, year; 
                citestyle=authoryear,autocite=inline,
                sorting=nyt,maxbibnames=3,uniquelist=false, % sorting, max number of names, and not reindexing repeated names
                giveninits=true]{biblatex} % abb for names is true
\defbibheading{bibliography}{%
    \chapter*{References}%
    \addcontentsline{toc}{chapter}{#1}%
}
\let\cite\textcite   % rename cite command
\let\citep\parencite % rename cite command


% ------------------------------------------------------------
% ITEMIZE SETUP
\setlist[itemize,1]{label={\raisebox{0.2ex}{\scalebox{0.8}[1]{$\blacktriangleright$}}}, left=0pt, itemsep=2pt, labelsep=2pt}
\setlist[itemize,2]{label={\raisebox{0.02ex}{\scalebox{1}{$\circ$}}}, left=0pt, itemsep=2pt, labelsep=2pt}
\setlist[itemize,3]{label={\raisebox{0.3ex}{\scalebox{1.3}{\rule{0.5ex}{0.5ex}}}}, left=0pt, itemsep=2pt, labelsep=3pt}
\setlist[enumerate]{label=(\alph*)., labelsep=0.3em}


% ------------------------------------------------------------
% COVER PAGE

\newcommand{\coverpage}[3]{%
    % #1 = Book Title
    % #2 = Author
    % #3 = Date
    \begingroup
    \thispagestyle{empty}
    \vspace*{\fill}
    \begin{tcolorbox}[
        enhanced,
        left=10mm,
        right=10mm,
        top=4mm,
        bottom=5mm,
        spread sidewards,
        sharp corners,
        colback=amzchaptercolor,
        colframe=amzchaptercolor,
        boxrule=1mm,
        drop fuzzy shadow,
        fontupper=\color{white}\centering\singlespacing
    ]
        \Huge\bfseries\strut#1 \\[1ex]
        \Large\mdseries#2 on #3
    \end{tcolorbox}
    \vspace*{\fill}
    \endgroup
    \clearpage
    \addtocounter{page}{-1}
}
\renewcommand*{\nameyeardelim}{\addcomma\space}

\ifamznotes@math % if amznotes@math is true (i.e., write `\documentclass[math]{amznotes}` in the main tex)
    \RequirePackage{mathtools}          % for math macros; also loads amsmath
    \RequirePackage{amsthm}
    \renewcommand{\qedsymbol}{\hbox{\quad\rule{1.5ex}{1.5ex}}} % renew command \qedsymbol already loaded from amsthm
    \renewcommand{\proofname}{\bfseries{\upshape Proof}}
    \renewenvironment{proof}[1][\proofname]{%
      \par
      \pushQED{\qedsymbol}%
      \normalfont
      \topsep6\p@\@plus6\p@ \trivlist
      \item[\hskip\labelsep\bfseries\upshape #1\@addpunct{.}]\noindent
    }{%
      \vspace{-\abovedisplayskip}
      \qed\endtrivlist\@endpefalse
    }
    \RequirePackage{derivative}         % symbols for derivatives
\fi

\ifamznotes@code
    \RequirePackage{minted}             % syntax coloring for code
    \tcbuselibrary{minted}              % command `tcbuselibrary` is from `tcolorbox`
    % here `minted` has default framework for coloring code, but `tcbuselibrary` enables more diverse types of color boxes
\fi


% ------------------------------------------------------------
% FONTS

\setmainfont{STIXTwoText}[ % set main font from font familiy of STIXTwoText
  Extension = .otf,        % will use font config within .otf files 
  UprightFont = *-Regular, % normal font (non bold, italic, etc) use config from file of `STIXTwoText-Regular.otf`
  BoldFont = *-SemiBold,
  ItalicFont = *-Italic,
  BoldItalicFont = *-SemiBoldItalic,
  WordSpace = 1.05,
  PunctuationSpace = 1.3
]

% Chinese font: Noto Sans CJK SC if installed, otherwise FandolHei (ships with TeX Live)
\IfFontExistsTF{Noto Sans CJK SC}{%
    \setCJKmainfont{Noto Sans CJK SC}
    \setCJKsansfont{Noto Sans CJK SC}
    \setCJKmonofont{Noto Sans Mono CJK SC}
}{%
    \setCJKmainfont{FandolHei}
    \setCJKsansfont{FandolHei}
    \setCJKmonofont{FandolHei}
}

% ------------------------------------------------------------
% PAGE LAYOUT

\onehalfspacing % make spaces between lines x 1.5 of default size 
\renewcommand{\arraystretch}{1.25} % increase vertical space between table lines to 1.5 x default size
\AtBeginDocument{%
    \setlength{\abovedisplayskip}{3pt plus 1pt minus 1pt}%
    \setlength{\belowdisplayskip}{3pt plus 1pt minus 1pt}%
}


% ------------------------------------------------------------
% COLORS

% Color palette from https://flatuicolors.com/palette/us
\definecolor{amzchaptercolor}{HTML}{0984e3}
\definecolor{amzdefboxcolor}{HTML}{0984e3}
\definecolor{amzthmboxcolor}{HTML}{6c5ce7}
\definecolor{amzexboxcolor}{HTML}{fdcb6e}
\definecolor{amzgenboxcolor}{HTML}{00b894}
\definecolor{amztecboxcolor}{HTML}{e17055}
\definecolor{amzcodeboxcolor}{HTML}{2d3436}
\definecolor{amznoteboxcolor}{HTML}{d63031}
\definecolor{amzasmpboxcolor}{HTML}{ff7675}


% ------------------------------------------------------------
% LINKS

\hypersetup{
    colorlinks=false,
    linkbordercolor=black,
    urlbordercolor=blue,
    pdfborderstyle={/S/U/W 1}   % Underline links; only appears in pdf viewer, not printed
}


% ------------------------------------------------------------
% CHAPTER STYLING

\ifamznotes@fastcompile % if fastcompile is specified, then the latter fancy fonts will not be applied
\else

\titleformat{\chapter}[display] % [display] makes `Chapter x` and chapter title text in two consecutive lines
{\normalfont\huge\bfseries} % chapter title and label format, \normalfont ensures overriding default chapter title font
{} % label name, for example, \thechapter. Empty here will just adding empty space
{20pt} % this is the space between label and title. Since label is empty, then this just add more space before title.
{
    \begin{tcolorbox}[
        enhanced,
        left=0.43in,
        right=0.5in,
        top=2mm,
        spread sidewards, % make the box stretched to the edges of the page
        sharp corners,    % box with squared corners
        colback=amzchaptercolor, 
        colframe=amzchaptercolor, % box fill color and border color the same
        boxrule=1mm,  % thickness of the border
        title=\thechapter, % set box title as the chapter number. technically, it is not chapter label
        attach boxed title to top right={xshift=-15mm, yshift=-4mm},
        boxed title style={
            size=small, % box title small font
            colback=amzchaptercolor, % box title background color
            colframe=white % border color of box title
        }
    ]
        \strut % this will make 0.7\baselineskip as height and 0.3\baselineskip as depth, where \baselineskip is vertical length between two baselines, depth is length below baseline, height is length above baseline, baseline could be treat as third line in 4-line handwriting system
        \textcolor{white}{#1} % colors for box title and box content
    \end{tcolorbox}
}

\titleformat{name=\chapter,numberless}[display]{\normalfont\huge\bfseries}% chapter level title w/t indexing (e.g., index), which will not appear in toc
{}
{20pt}
{
    \begin{tcolorbox}[
        enhanced,
        left=0.43in,
        right=0.5in,
        top=2mm,
        spread sidewards,
        sharp corners,
        colback=amzchaptercolor,
        colframe=amzchaptercolor,
        boxrule=1mm,
    ]
        \strut \textcolor{white}{#1}
    \end{tcolorbox}
}

\titlespacing*{\chapter}{0pt}{-40mm}{-10mm} % spacing before/above/below the title

\fi %\ifamznotes@fastcompile

% ------------------------------------------------------------
% PICTURES
% \mpic{file}[width ratio][space before][space after]; floats cannot be used inside tcolorboxes
\NewDocumentCommand{\mpic}{m O{0.5} O{0.5em} O{0.5em}}{%
  \par\addvspace{#3}%
  \noindent
  \begin{minipage}{\linewidth}
    \centering
    \includegraphics[width=#2\linewidth]{#1}%
  \end{minipage}%
  \par\addvspace{#4}%
}


% ------------------------------------------------------------
% SECTION STYLING

% \sectionfont{\color{amzchaptercolor}}  % sets colour of sections


% ------------------------------------------------------------
% HEADER STYLING

\ifamznotes@fastcompile
\else

\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\lhead{\footnotesize\nouppercase{\leftmark}} % left header font and \leftmark refers to chapter title, \nouppercase make chapter title not force all upper case
\rhead{\footnotesize\nouppercase{\rightmark}} % \rightmark is current section title 
\cfoot{\thepage\ of \pageref{LastPage}}

\fancypagestyle{plain}{ % this command define how pages with chapter titles like: no headers, but page number in footer still align with other pages. "plain" is page style for chapter title page
    \renewcommand{\headrulewidth}{0pt} % no underline for header
    \fancyhead{}
    \cfoot[C]{\thepage\ of \pageref{LastPage}}
}

\fi %\ifamznotes@fastcompile


% ------------------------------------------------------------
% COLOR BOXES
\newcommand{\amzcolorboxtitlesep}{\ \raisebox{2pt}{\scalebox{0.5}{ $\blacktriangleright$}}} % a space + 0.5 scaled right triangle shifted up for 2pt

\ifamznotes@fastcompile
\tcbset{
    amzdefaultstyle/.style={
        fonttitle=\strut\bfseries,  % strut for uniform title height
        separator sign=\amzcolorboxtitlesep,
        breakable
    },
    genboxstyle/.style={
        amzdefaultstyle,
        breakable
    },
    asmpboxstyle/.style={
            amzdefaultstyle,
            breakable
        },
    noteboxstyle/.style={breakable},
    codeboxstyle/.style={
        overlay={\begin{tcbclipinterior}\fill[darkgray!20!white] (frame.south west) rectangle ([xshift=4mm]frame.north west);\end{tcbclipinterior}},
        skin=bicolor,
        collower=white,
        colbacklower=darkgray,
        breakable
    },
    refboxstyle/.style={breakable},
}


\else %\ifamznotes@fastcompile
\tcbset{
    amzdefaultstyle/.style={
        enhanced,
        drop fuzzy shadow, % drop shadow is a visual effect that adds a soft, dark, and slightly offset copy of an object behind it; fuzzy makes edge of the shadow blurred
        fonttitle=\strut\bfseries,  % strut for uniform title height
        boxrule=0pt,
        frame hidden, % fuzzy shadow makes frame always exists, thus this is sort of redundant
        separator sign=\amzcolorboxtitlesep,
        % parbox=false,               % normal paragraph spacing
        breakable,
    },
    genboxstyle/.style={
        amzdefaultstyle,
        frame style={fill=amzgenboxcolor!85!black},
        interior style={fill=amzgenboxcolor!5!white},
        segmentation style={solid,draw=amzgenboxcolor!50!black,opacity=0.25,line width=1pt},
        breakable
    },
    asmpboxstyle/.style={
        amzdefaultstyle,
        frame style={fill=amzasmpboxcolor!85!black},
        interior style={fill=amzasmpboxcolor!5!white},
        segmentation style={solid,draw=amzasmpboxcolor!50!black,opacity=0.25,line width=1pt},
        breakable
    },
    noteboxstyle/.style={
        enhanced,
        boxrule=0pt, % Ensures no default border is drawn
        % frame hidden, % You can keep this or remove it; it's redundant with boxrule=0pt
        borderline west={4pt}{0pt}{amznoteboxcolor}, % Keeps the left accent bar
        colback=amznoteboxcolor!7!white,
        sharp corners,
        frame style={fill=amznoteboxcolor!7!white, draw=none}, % Critical: removes the frame border
        interior style={fill=amznoteboxcolor!7!white},
        fonttitle=\strut\bfseries\color{amznoteboxcolor},
        title={\faInfoCircle\ Note},
        overlay unbroken={
        \draw[amznoteboxcolor, line width=1pt]
                ([yshift=2pt]title.south west) -- ([yshift=2pt]title.south east);
        },
        overlay first={
            \draw[amznoteboxcolor, line width=1pt]
                ([yshift=2pt]title.south west) -- ([yshift=2pt]title.south east);
        },
        breakable
    },
    refboxstyle/.style={
        enhanced,
        boxrule=0pt,
        frame hidden,
        borderline west={4pt}{0pt}{darkgray},
        colback=darkgray!2!white,
        sharp corners,
    },
    codeboxstyle/.style={
        overlay={\begin{tcbclipinterior}\fill[darkgray!20!white] (frame.south west) rectangle ([xshift=4mm]frame.north west);\end{tcbclipinterior}}, % this part specify numbering of lines of the code block. note the option is like dragging from one corner to another
        skin=bicolor,
        collower=white,
        colbacklower=darkgray
    },
}

\fi %\ifamznotes@fastcompile

% Give the index numbers some more space
\renewcommand{\l@tcolorbox}{\@dottedtocline{1}{0pt}{3em}} % section level, indent before numbering, width between numbering and names
\setlength{\columnsep}{3em} % space between columns

% \newcommand{\amzindex}{
%     \addcontentsline{toc}{chapter}{Index} % add Index to toc as chapter - level entry
%     \chapter*{Index} % since this no-numbering chapter also do not add into toc, then need manual adding

%     % Remove header for index. This part is redundant because already defined \chapter*{} to w/t header
%     \renewcommand{\headrulewidth}{0pt}
%     \fancyhead{}

%     \begin{multicols}{2} % \setlength{\columnsep}{3em} not only works on this, but also works globally on such environement (but not tabular, array, minipage, etc). could make it local by putting the line before \begin{multicols} here
%         \amzindexbody
%     \end{multicols}
% }
\newcommand{\amzindex}{
    \chapter*{Index} % Create the title first
    \addcontentsline{toc}{chapter}{Index} % Then add the TOC entry, so the anchor is at the title

    % Remove header for index.
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}

    \begin{multicols}{2}
        \amzindexbody
    \end{multicols}
}


\newcommand{\amzindexbody}{}

\newcommand{\addindexentry}[2]{%  % [2] means takes two arguments, #1 and #2
    \appto\amzindexbody{
        \iftoggle{#2}{
            \tcblistof[\section*]{#2}{#1} % when writing this, will use renewed format defined by \l@tcolorbox automatically
        }{}
    }
}

%\newamzbox{environment name}{title}{ref label}{color}[tcolorbox style]
\newcounter{amzboxcounter} % counter of boxes (def 1.1, thm 1.2., eg 1.3, instead of counting def, thm, eg separately)
\NewDocumentCommand{\newamzbox}{m m m m O{}}{
    % \newtcbtheorem[<init options>]{<name>}{<display name>}{<style>}{<prefix>}
    \newtcbtheorem[use counter=amzboxcounter,number within=section,list inside={#3}]{tc#1}{#2}{
        amzdefaultstyle,
        frame style={fill=#4!85!black},
        interior style={fill=#4!5!white},
        segmentation style={solid,draw=#4!50!black,opacity=0.25,line width=1pt},
        before upper=\noindent,
        #5 % note segmentation requires \tcblower command when writing, otherwise no segmentation
    }{#3}

    \providetoggle{#3} % boolean flag for label of box type
    \settoggle{#3}{false} % set flag to false

    \newenvironment{#1}[2]{
        \global\settoggle{#3}{true} % if new defbox is created, then create a global toggle with def assigned with true
        \begin{tc#1}{##1}{##2}
    }{
        \end{tc#1}
    } % note two {} for begin and end respectively corresponds to begin and end in the actual calling

    \newenvironment{#1*}[1]{
        \begin{tc#1*}{##1}
    }{
        \end{tc#1*}
    }

    \addindexentry{#2s}{#3}
}

\newamzbox{defbox}{Definition}{def}{amzdefboxcolor}
\newamzbox{stbox}{Setup}{st}{amzdefboxcolor}
\newamzbox{agrbox}{Algorithm}{agr}{amzthmboxcolor}
\newamzbox{exbox}{Example}{ex}{amzexboxcolor}
\newamzbox{tecbox}{Technique}{tec}{amztecboxcolor}
% \newamzbox{asmpbox}{Assumption}{asmp}{amzasmpboxcolor}
% Custom assumption box with separate counter
\newcounter{amzasmp}[section]  % Counter that resets each section
\renewcommand{\theamzasmp}{\arabic{amzasmp}}
% Define the tcb version with custom counter
\newtcbtheorem[use counter=amzasmp,list inside={asmp}]{tcasmpbox}{Assumption}{
    amzdefaultstyle,
    frame style={fill=amzasmpboxcolor!85!black},
    interior style={fill=amzasmpboxcolor!5!white},
    segmentation style={solid,draw=amzasmpboxcolor!50!black,opacity=0.25,line width=1pt},
    before upper=\noindent,
}{asmp}

\providetoggle{asmp}
\settoggle{asmp}{false}
% Define the user-facing environment
\newenvironment{asmpbox}[2]{
    \global\settoggle{asmp}{true}
    \begin{tcasmpbox}{#1}{#2}
}{
    \end{tcasmpbox}
}

\newtcolorbox{genbox}[1]{amzdefaultstyle, genboxstyle, title={#1}} % here just keeping genboxstyle is fine because it covers all config in amzdefaultstyle
\newtcolorbox{notebox}{noteboxstyle}
\newtcolorbox{refbox}{refboxstyle}

\ifamznotes@math
    \newamzbox{lembox}{Lemma}{lem}{amzthmboxcolor}
    \newamzbox{thmbox}{Theorem}{thm}{amzthmboxcolor}
    \newamzbox{prpbox}{Proposition}{prp}{amzthmboxcolor}
    \newamzbox{fctbox}{Fact}{fct}{amzthmboxcolor}
    \newamzbox{solbox}{Optimization Solution}{sol}{amzthmboxcolor}
\fi

\ifamznotes@code
    % \renewcommand{\theFancyVerbLine}{\ttfamily\footnotesize{\arabic{FancyVerbLine}}}
    % use typewriter font, scriptsized, arabic numering for lines
    \renewcommand{\theFancyVerbLine}{%
          \raisebox{0.05ex}{\ttfamily\small\arabic{FancyVerbLine}}%
    }
    \newamzbox{codebox}{Code Snippet}{code}{amzcodeboxcolor}[codeboxstyle]

    \newenvironment{amzcode}[2][]{ % inline code, two input arg, with first one be optional
        \VerbatimEnvironment % tell latex here do not mislead content as latex input (e.g., symbols $, _, %)
        \begin{minted}[
        linenos,            % Display line numbers
        breaklines,         % Allow line breaks
        autogobble,         % Collapse extra white spaces
        xleftmargin=0.2mm,
        numbersep=2.5mm
        ]{#2}}
    {\end{minted}}

    \newcommand{\amzinputcode}[2]{\inputminted[ % input external code file
        linenos,            % Display line numbers
        breaklines,         % Allow line breaks
        autogobble,         % Collapse extra white spaces
        xleftmargin=0.2mm,
        numbersep=2.5mm
    ]{#1}{#2}}
\fi

% ------------------------------------------------------------
% TEXT MACROS

\newcommand{\deftxt}[1]{\textit{\textbf{#1}}}

% from https://tex.stackexchange.com/a/150650
\newcommand{\tabitem}{~~\llap{\textbullet}~~}
% a bullet point line that: two spaces (~~) + no spacing around textbullet + two spaces

% ------------------------------------------------------------
% MATH MACROS

\ifamznotes@math
    \newcommand{\rel}[1]{\mathrel{\mathcal{#1}}}
    \newcommand{\N}{\mathbb{N}}
    \newcommand{\Z}{\mathbb{Z}}
    \newcommand{\Q}{\mathbb{Q}}
    \newcommand{\R}{\mathbb{R}}
    \newcommand{\C}{\mathbb{C}}
    \newcommand{\F}{\mathbb{F}}
    \newcommand{\ept}{\varnothing}
    \newcommand{\bs}{\boldsymbol}
    \newcommand{\sm}{\backslash}
    \newcommand{\epi}{\mathrm{epi}}
    \newcommand{\sub}{\mathrm{sub}}
    \newcommand{\mcd}{\mathcal{D}}
    \newcommand{\sign}{\operatorname{sign}}
    \newcommand{\st}{\quad\text{s.t.}\quad}
    \newcommand{\uda}{\Updownarrow}
    \newcommand{\gr}{\mathrm{Graph}}

    \DeclareMathOperator{\laplace}{\mathscr{L}}
    \DeclareMathOperator{\proj}{proj} % this means \mathrm{proj}, used within $$
    \DeclareMathOperator{\comp}{comp}
    \DeclareMathOperator{\TIME}{TIME}


    \newcommand{\id}{\text{id}}
    \newcommand{\bigO}{\mathcal{O}}
    \newcommand{\symdiff}{\bigtriangleup}
    \newcommand{\pd}[2]{\frac{\partial #1}{\partial #2}}

    \newcommand{\alg}[1]{{\left\langle {#1} \right\rangle}}

    \DeclarePairedDelimiter\abs{\lvert}{\rvert}    \DeclarePairedDelimiter\norm{\lVert}{\rVert}
    \DeclarePairedDelimiter\ceil{\lceil}{\rceil}
    \DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
    \DeclarePairedDelimiter\en{\|}{\|}
    \DeclarePairedDelimiter\bra{(}{)}
    \DeclarePairedDelimiter\sqb{[}{]}
    \DeclarePairedDelimiter\rb{(}{)}
    \DeclarePairedDelimiter\cb{\{}{\}}
    % enables some options to the symbol. e.g., $\abs[\big]{x}$ coud make abs signs | | larger;  $\abs*{\frac AB}$ could make abs sign adjust to the size of fraction
    
    % Function Restriction
    % From https://tex.stackexchange.com/a/22255
    \newcommand\restrict[2]{{ % this is definite derivative sign
        \left.\kern-\nulldelimiterspace % \left. is invisible deliminator; 
        #1                              % \kern-\nulldelimiterspace is adding horizontal space minus diliminator space
        \vphantom{\big|} % add a symbol that does not take any space but take height of \big|
        \right|_{#2}
    }}
    \newcommand{\qq}[1]{\textquotedbl #1\textquotedbl}
    \newcommand{\bb}[1]{\mathbf{#1}}
\fi %\ifamznotes@math