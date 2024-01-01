%===============================================================================
%================================= Definition ==================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{practical-cv}

%===============================================================================
%============================= page setup & options ============================

% paper size option
\DeclareOption{a4paper}{
  \setlength\paperheight{297mm}
  \setlength\paperwidth{210mm}}
\DeclareOption{letterpaper}{
  \setlength\paperheight{11in}
  \setlength\paperwidth{8.5in}}

% font size options
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

% execute default options
\ExecuteOptions{a4paper,11pt,final}

% process given options
\ProcessOptions\relax
\input{size1\@ptsize.clo}

% Page margins
\RequirePackage{geometry}
\geometry{top=1in, bottom=1.25in, left=1.25in, right=1.25in}

%===============================================================================
%==================================== base =====================================

% Alignment and one column
\RequirePackage[document]{ragged2e}
\raggedbottom
\onecolumn

% Set linespacing to 1.1 times the point size
\RequirePackage{setspace}
\setstretch{1.1}

% No indent
\RequirePackage{parskip}

% \AtEndPreamble hook (loading etoolbox instead of defining the macro, as to avoid incompatibilities with etoolbox (and packages relying on it) defining the macro too)
\RequirePackage{etoolbox}

% Last page package
\RequirePackage{lastpage}

% if... then... else... constructs
\RequirePackage{ifthen}
% TODO: move to xifthen and \isempty{<arg>} instead of \equal{<arg>}{}

% hyper links (hyperref is loaded at the end of the preamble to pass options required by loaded packages such as CJK)
\newcommand*\pdfpagemode{UseNone}% do not show thumbnails or bookmarks on opening (on supporting browsers); set \pdfpagemode to "UseOutlines" to show bookmarks
\RequirePackage{url}
\urlstyle{tt}

\AtEndPreamble{
  \pagenumbering{arabic}% has to be issued before loading hyperref, as to set \thepage and hence to avoid hyperref issuing a warning and setting pdfpagelabels=false
  \RequirePackage[unicode]{hyperref}% unicode is required for unicode pdf metadata
  \hypersetup{
    breaklinks,
    colorlinks    = true,
    allcolors     = AmmaBlue,
    baseurl       = https://,
    pdfborder     = 0 0 0,
    pdfpagemode   = \pdfpagemode,
    pdfstartpage  = 1,
    pdfcreator    = {TexLive},
    bookmarksopen = true,
    bookmarksdepth= 1,
    pdfauthor     = {\@firstname{}~\@lastname{}},
    pdftitle      = {\@firstname{}~\@lastname{} -- CV},
    pdfsubject    = {CV of \@firstname{}~\@lastname{}},
    pdfkeywords   = {\@firstname{}~\@lastname{}, curriculum vit\ae{}}}}

% headers and footers
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhf{}}

% page numbers in footer
\AtEndPreamble{%
  \AtBeginDocument{%
        \cfoot{\sansclight page \thepage\ of \pageref{LastPage}}
      }
    }
\pagestyle{plain}

% lengths calculations
\RequirePackage{calc}

% micro-typography (e.g., character protrusion, font expansion, hyphenatable letterspacing)
\RequirePackage[final,protrusion={true,compatibility}, expansion=true]{microtype}

% stack of key-value elements, used to save personal information
\RequirePackage{moderncvcollection}

% creates a length if not yet defined
\newcommand*{\@initializelength}[1]{%
  \ifdefined#1
  \else%
    \newlength{#1}\fi%
  \setlength{#1}{0pt}}

% creates a box if not yet defined
\newcommand*{\@initializebox}[1]{%
  \ifdefined#1
    \savebox{#1}{}%
  \else%
    \newsavebox{#1}\fi}

% icons for social sites
\RequirePackage{fontawesome5}

%===============================================================================
%================================= typography ==================================

\RequirePackage{unicode-math}

\setmainfont[
    Numbers={Lowercase,Proportional}, 
    Contextuals=Alternate,
    WordSpace=1.08
    ]{Equity A}
    
\setsansfont[
    Numbers={Lowercase,Proportional}, 
    Contextuals=Alternate,
    WordSpace=1.08
    ]{Concourse 3}

\newfontfamily{\sansc}{Concourse 4 Caps}[Letters=UppercaseSmallCaps, LetterSpace=5, WordSpace=1.08, Numbers={Lowercase,Proportional}]
\newfontfamily{\sansclight}{Concourse 3 Caps}[Letters=UppercaseSmallCaps, LetterSpace=5, WordSpace=1.08, Numbers={Lowercase,Proportional}]
\newfontfamily{\rmsc}{Equity A Caps}[Letters=UppercaseSmallCaps, LetterSpace=5, WordSpace=1.08, Numbers={Lowercase,Proportional}]

% Oldstyle tabular numbers inside tabular environment
\AtBeginEnvironment{tabular}{\addfontfeatures{Numbers={Uppercase, Monospaced}}\small}
\renewcommand{\theequation}{ {\addfontfeatures{Numbers={Uppercase, Monospaced}}\small\arabic{equation}}}

% French Spacing - single spacing between sentences
\frenchspacing

%===============================================================================
%============================== personal details ===============================

% name
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}

% address/title
\renewcommand*{\title}[1]{\def\@title{#1}}

% email
\newcommand*{\email}[1]{\def\@email{#1}}

% homepage
\newcommand*{\homepage}[1]{\def\@homepage{#1}}

% pronouns
\newcommand*{\pronouns}[1]{\def\@pronouns{#1}}

%===============================================================================
%=================================== colors ====================================

\RequirePackage{xcolor}
\definecolor{MokaRed}{HTML}{D73A49} % my red
\definecolor{AmmaBlue}{HTML}{0366D6} % my blue

%===============================================================================
%================================ new commands =================================

% fonts
\newcommand*{\namefont}{}
\newcommand*{\titlefont}{}
\newcommand*{\socialsfont}{}
\newcommand*{\sectionfont}{}
\newcommand*{\subsectionfont}{}

% styles
\newcommand*{\namestyle}[1]{{\namefont#1}}
\newcommand*{\titlestyle}[1]{{\titlefont#1}}
\newcommand*{\socialsstyle}[1]{{\socialsfont#1}}
\newcommand*{\sectionstyle}[1]{{\sectionfont#1}}
\newcommand*{\subsectionstyle}[1]{{\subsectionfont#1}}

% recompute all resume lengths
\newcommand*{\recomputecvheadlengths}{}
\newcommand*{\recomputecvbodylengths}{}
\newcommand*{\recomputecvfootlengths}{}
\newcommand*{\recomputecvlengths}{%
  \recomputecvheadlengths%
  \recomputecvbodylengths%
  \recomputecvfootlengths}

% internal maketitle command to issue a new line only when required
\newif\if@firstdetailselement\@firstdetailselementtrue
\newcommand*{\makenewline}[1][0pt]{%
  \if@firstdetailselement%
    \strut% to ensure baseline alignment, e.g. with when put in the margin vs sections that also contains a \strut
  \else%
    \\[#1]\fi%
  \@firstdetailselementfalse}

% makes the resume title
% usage: \makecvtitle
\newcommand*{\makecvtitle}{%
  \makecvhead%
  \makecvfoot}
\newcommand*{\makecvhead}{}
\newcommand*{\makecvfoot}{}

% makes a resume section
% usage: \section{<title>}
\NewDocumentCommand{\section}{sm}{}

% makes a resume subsection
% usage: \subsection{title}
\NewDocumentCommand{\subsection}{sm}{}

% makes a resume line with a header and a corresponding text
% usage: \cvitem[spacing]{header}{text}
\newcommand*{\cvitem}[3][.25em]{}

% makes a typical resume job / education entry
% usage: \cventry[spacing]{years}{degree/job title}{institution/employer}{localization}{optionnal: grade/...}{optional: comment/job description}
\newcommand*{\cventry}[6][.25em]{}
\newcommand*{\smallentry}[4][.25em]{}

%===============================================================================
%==================================== header ===================================

% fonts
\renewcommand*{\namefont}{\Huge\sffamily}
\renewcommand*{\titlefont}{\sansclight}
\renewcommand*{\socialsfont}{\small\sffamily}

% styles
\renewcommand*{\namestyle}[1]{{\namefont\textcolor{MokaRed}{#1}}}
\renewcommand*{\titlestyle}[1]{{\titlefont{#1}}}
\renewcommand*{\socialsstyle}[1]{{\socialsfont{#1}}}

% lengths
\@initializelength{\makecvheadnamewidth}% optional makecvheadname width to force a certain width (if set/remains to 0pt, the width is calculated automatically)

% commands
\renewcommand*{\makecvhead}{
    % recompute lengths (in case we are switching from letter to resume, or vice versa)
    \recomputecvlengths%
    % optional detailed information (pre-rendering)
    \@initializebox{\makecvheaddetailsbox}
    \savebox{\makecvheaddetailsbox}{%
        \socialsfont%
        \begin{tabular}[b]{@{}r@{}}
            \ifthenelse{\isundefined{\@pronouns}}{}{\makenewline{\small\faUser[regular]}\space\@pronouns}
            \ifthenelse{\isundefined{\@homepage}}{}{\makenewline{\small\faGlobe}~\href{https://\@homepage}{\space\@homepage}}
            \ifthenelse{\isundefined{\@email}}{}{\makenewline{\small\faEnvelope[regular]}~\href{mailto:\@email}{\space\@email}}
            
        \end{tabular}
    }

    % name and title (pre-rendering)
    \@initializebox{\makecvheadpicturebox}
    \@initializelength{\makecvheaddetailswidth}\settowidth{\makecvheaddetailswidth}{\usebox{\makecvheaddetailsbox}}%
    \@initializelength{\makecvheadpicturewidth}\settowidth{\makecvheadpicturewidth}{\usebox{\makecvheadpicturebox}}%
    \ifthenelse{\lengthtest{\makecvheadnamewidth=0pt}}% check for dummy value (equivalent to \ifdim\makecvheadnamewidth=0pt)
    {\setlength{\makecvheadnamewidth}{\textwidth-\makecvheaddetailswidth-\makecvheadpicturewidth}}%
    {}%
    \@initializebox{\makecvheadnamebox}%
    \savebox{\makecvheadnamebox}{%
    \begin{minipage}[b]{\makecvheadnamewidth}%
      \raggedright
      \namestyle{\@firstname\ \@lastname}%
      \ifthenelse{\equal{\@title}{}}{}{\\[0.5\baselineskip]\titlestyle{\@title}}%
    \end{minipage}}%
    % rendering
    \usebox{\makecvheadnamebox}%
    \hfill%
    \llap{\usebox{\makecvheaddetailsbox}}% \llap is used to suppress the width of the box, allowing overlap if the value of makecvheadnamewidth is forced
    \usebox{\makecvheadpicturebox}
    \\[-1em]
    \par% to avoid weird spacing bug at the first section if no blank line is left after \makecvhead
}


%===============================================================================
%=============================== body definition ===============================

% fonts
\renewcommand*{\sectionfont}{%
  \sansc
}

\renewcommand*{\subsectionfont}{%
  \itshape
}

% styles
\renewcommand*{\sectionstyle}[1]{{
  \sectionfont\textcolor{MokaRed}{#1}
}}

\renewcommand*{\subsectionstyle}[1]{{
  \subsectionfont{#1}
}}


% lengths
%   used by \cvitem (and all children command)
\@initializelength{\separatorcolumnwidth}         \setlength{\separatorcolumnwidth}{0.025\textwidth}
\@initializelength{\maincolumnwidth}

% commands
\renewcommand*{\recomputecvbodylengths}{%
  % body lengths
  \setlength{\maincolumnwidth}{\textwidth-\leftskip-\rightskip}
  % regular lengths
  \setlength{\parskip}{0\p@}}

\RenewDocumentCommand{\section}{sm}{%
  \par\addvspace{\baselineskip}%
  \phantomsection{}
  % Ensures that the sectionrule and the heading are on the same page
  \vbox{
  \sectionrule\\
  \sectionstyle{#2}
  }
  \par\nobreak\addvspace{0.5\baselineskip}\@afterheading
}

\RenewDocumentCommand{\subsection}{sm}{%
  \par\addvspace{0.5\baselineskip}
  \phantomsection{}
  \subsectionstyle{#2}
  \par\nobreak\@afterheading
}

% Line before section title
\newcommand*{\sectionrule}{\par\nobreak\leavevmode{\color{MokaRed}\leaders\hbox{\rule{1pt}{0.4pt}}\hfill\kern0pt}}

\renewcommand*{\cvitem}[3][.25em]{
  \ifthenelse{\equal{#2}{}}{

  }
  {
    {\bfseries #2}:
  }
  {#3}
  \par\addvspace{#1}
}

\renewcommand*{\cventry}[6][1em]{
    \addvspace{#1}
    {
        \renewcommand{\arraystretch}{1.12}
        \ifthenelse{\equal{#6}{}}{
            \begin{tabular*}{\maincolumnwidth}{l@{\extracolsep{\fill}}r}
                {\large #3} & {\large #4}\\
                {\itshape #2} & {\small\rmsc #5}\\
            \end{tabular*}
        }
        {
            \begin{tabular*}{\maincolumnwidth}{l@{\extracolsep{\fill}}r}
                {\large #3} & {\large #4}\\
                {\itshape #2} & {\small\rmsc #5}\\
                \multicolumn{2}{p{\textwidth}}{#6}\\
            \end{tabular*}
        }
    }
}

\renewcommand*{\smallentry}[4][1em]{
    \addvspace{#1}
    \begin{tabular*}{\maincolumnwidth}{l@{\extracolsep{\fill}}r}
        {#2} & {#3}\\[0.2em]
        \multicolumn{2}{p{\textwidth}}{#4}\\
    \end{tabular*}
}

%===============================================================================
%=============================== bibliography ==================================

\RequirePackage[backend=biber,
                citestyle=numeric,
                bibstyle=authoryear,
                natbib=true,
                maxbibnames=999,
                sorting=none,
                defernumbers=true,
                url=false,
                doi=false]{biblatex}

\renewcommand*{\mkbibnamegiven}[1]{%
                  \ifitemannotation{highlight}
                    {\textbf{#1}}
                    {#1}}
                
\renewcommand*{\mkbibnamefamily}[1]{%
  \ifitemannotation{highlight}
    {\textbf{#1}}
    {#1}}


% Set separation between bib entries
\setlength\bibitemsep{1em}

% Print all entries in bib file without explicit cite command
\AtEndPreamble{
    \nocite{*}
    \DeclareNameAlias{author}{first-last}
    \DeclareFieldFormat{labelnumber}{#1\adddot\addspace}
    \DeclareFieldFormat[misc]{title}{\mkbibquote{#1}}
    \DeclareFieldInputHandler{extradate}{\def\NewValue{}} % Hides letter after date for duplicate month-year entries
    \AtEveryBibitem{\printfield{labelnumber}}
}
