/*******************************************************************************
* Software: FPDF                                                               *
* Version:  1.53                                                               *
* Date:     2004-12-31                                                         *
* Author:   Olivier PLATHEY                                                    *
* License:  Freeware                                                           *
*                                                                              *
* You may use, modify and redistribute this software as you wish.              *
*******************************************************************************/
#ifndef __fpdf_h__
#define __fpdf_h__

#define FPDF_VERSION 1.53

#typedef double PRFloat64;
#typedef unsigned long PRUint32;

class fpdf 

{
//Private properties
 public:
  fpdf($orientation='P',$unit='mm',$format='A4');
  NS_IMETHODIMP SetMargins($left,$top,$right=-1);
  NS_IMETHODIMP LeftMargin($margin);
  NS_IMETHODIMP SetTopMargin($margin);
  NS_IMETHODIMP SetRightMargin($margin);
  NS_IMETHODIMP SetAutoPageBreak($auto,$margin=0);
  NS_IMETHODIMP SetDisplayMode($zoom,$layout='continuous');
  NS_IMETHODIMP SetCompression($compress);
  NS_IMETHODIMP SetTitle($title);
  NS_IMETHODIMP SetSubject($subject);
  NS_IMETHODIMP SetAuthor($author);
  NS_IMETHODIMP SetKeywords($keywords);
  NS_IMETHODIMP SetCreator($creator);
  NS_IMETHODIMP AliasNbPages($alias='{nb}');
  NS_IMETHODIMP Error($msg);
  NS_IMETHODIMP Open();
  NS_IMETHODIMP Close();
  NS_IMETHODIMP AddPage($orientation='');
  NS_IMETHODIMP Header(); //virtual
  NS_IMETHODIMP Footer();  //virtual
  NS_IMETHODIMP PageNo(PRUint32 * aPageNumber);
  NS_IMETHODIMP SetDrawColor($r,$g=-1,$b=-1);
  NS_IMETHODIMP SetFillColor($r,$g=-1,$b=-1);
  NS_IMETHODIMP SetTextColor($r,$g=-1,$b=-1);
  NS_IMETHODIMP GetStringWidth($s, PRFloat64 * aStringWidth);
  NS_IMETHODIMP SetLineWidth($width);
  NS_IMETHODIMP Line($x1,$y1,$x2,$y2);
  NS_IMETHODIMP Rect($x,$y,$w,$h,$style='');
  NS_IMETHODIMP AddFont($family,$style='',$file='');
  NS_IMETHODIMP SetFont($family,$style='',$size=0);
  NS_IMETHODIMP SetFontSize($size);
  NS_IMETHODIMP AddLink(PRUint32 * aLinkIndex);
  NS_IMETHODIMP SetLink($link,$y=0,$page=-1);
  NS_IMETHODIMP Link($x,$y,$w,$h,$link);
  NS_IMETHODIMP Text($x,$y,$txt);
  NS_IMETHODIMP AcceptPageBreak(PRBool * aAutoPageBreak); //
  NS_IMETHODIMP Cell($w,$h=0,$txt='',$border=0,$ln=0,$align='',$fill=0,$link='');
  NS_IMETHODIMP MultiCell($w,$h,$txt,$border=0,$align='J',$fill=0);
  NS_IMETHODIMP Write($h,$txt,$link='');
  NS_IMETHODIMP Image($file,$x,$y,$w=0,$h=0,$type='',$link='');
  NS_IMETHODIMP Ln($h='');
  NS_IMETHODIMP GetX(PRFloat64 * aX);
  NS_IMETHODIMP SetX($x);
  NS_IMETHODIMP GetY(PRFloat64 * aY);
  NS_IMETHODIMP SetY($y);
  NS_IMETHODIMP SetXY($x,$y);
  NS_IMETHODIMP Output($name='',$dest='', nsAString); // return result

/*******************************************************************************
*                                                                              *
*                              Protected methods                               *
*                                                                              *
*******************************************************************************/
  NS_IMETHODIMP _dochecks();
  NS_IMETHODIMP _getfontpath(nsAString &);
  NS_IMETHODIMP _putpages();
  NS_IMETHODIMP _putfonts();
  NS_IMETHODIMP _putimages();
  NS_IMETHODIMP _putxobjectdict();
  NS_IMETHODIMP _putresourcedict();
  NS_IMETHODIMP _putresources();
  NS_IMETHODIMP _putinfo();
  NS_IMETHODIMP _putcatalog();
  NS_IMETHODIMP _putheader();
  NS_IMETHODIMP _puttrailer();
  NS_IMETHODIMP _enddoc();
  NS_IMETHODIMP _beginpage($orientation);
  NS_IMETHODIMP _endpage();
  NS_IMETHODIMP _newobj();
  NS_IMETHODIMP _dounderline($x,$y,$txt); // return AString
  NS_IMETHODIMP _parsejpg($file); //return
  NS_IMETHODIMP _parsepng($file); //return
  NS_IMETHODIMP _freadint($f); //return
  NS_IMETHODIMP _textstring($s);  //return
  NS_IMETHODIMP _escape($s); //return
  NS_IMETHODIMP _putstream($s);
  NS_IMETHODIMP _out($s);

private:
  ~fpdf();
  PRUint32 $page;               //current page number
  PRUint32 $n;                  //current object number
  var $offsets;            //array of object offsets
  var $buffer;             //buffer holding in-memory PDF
  var $pages;              //array containing pages
  var $state;              //current document state
  var $compress;           //compression flag
  var $DefOrientation;     //default orientation
  var $CurOrientation;     //current orientation
  var $OrientationChanges; //array indicating orientation changes
  PRFloat64 $k;                  //scale factor (number of points in user unit)
  PRFloat64 $fwPt,$fhPt;         //dimensions of page format in points
  PRFloat64 $fw,$fh;             //dimensions of page format in user unit
  PRFloat64 $wPt,$hPt;           //current dimensions of page in points
  PRFloat64 $w,$h;               //current dimensions of page in user unit
  PRFloat64 $lMargin;            //left margin
  PRFloat64 $tMargin;            //top margin
  PRFloat64 $rMargin;            //right margin
  PRFloat64 $bMargin;            //page break margin
  PRFloat64 $cMargin;            //cell margin
  PRFloat64 $x,$y;               //current position in user unit for cell positioning
  PRFloat64 $lasth;              //height of last cell printed
  PRFloat64 $LineWidth;          //line width in user unit
  var $CoreFonts;          //array of standard font names
  var $fonts;              //array of used fonts
  var $FontFiles;          //array of font files
  var $diffs;              //array of encoding differences
  var $images;             //array of used images
  var $PageLinks;          //array of links in pages
  var $links;              //array of internal links
  var $FontFamily;         //current font family
  var $FontStyle;          //current font style
  var $underline;          //underlining flag
  var $CurrentFont;        //current font info
  var $FontSizePt;         //current font size in points
  var $FontSize;           //current font size in user unit
  var $DrawColor;          //commands for drawing color
  var $FillColor;          //commands for filling color
  var $TextColor;          //commands for text color
  var $ColorFlag;          //indicates whether fill and text colors are different
  PRFloat64 $ws;                 //word spacing
  var $AutoPageBreak;      //automatic page breaking
  var $PageBreakTrigger;   //threshold used to trigger page breaks
  var $InFooter;           //flag set when processing footer
  var $ZoomMode;           //zoom display mode
  var $LayoutMode;         //layout display mode
  var $title;              //title
  var $subject;            //subject
  var $author;             //author
  var $keywords;           //keywords
  var $creator;            //creator
  var $AliasNbPages;       //alias for total number of pages
  PRFloat64 $PDFVersion;         //PDF version number

}

#endif
