FasdUAS 1.101.10   ��   ��    k             l     ��  ��    - '-- Filter Songs by the typed query ----     � 	 	 N - -   F i l t e r   S o n g s   b y   t h e   t y p e d   q u e r y   - - - -   
  
 l     ��������  ��  ��        l     ��  ��      Configurable options --     �   0   C o n f i g u r a b l e   o p t i o n s   - -      l     ��������  ��  ��        l     ��  ��    2 , limit number of songs to improve efficiency     �   X   l i m i t   n u m b e r   o f   s o n g s   t o   i m p r o v e   e f f i c i e n c y      l     ����  r         m     ���� 	  o      ���� 0 	songlimit 	songLimit��  ��        l     ��   ��    ? 9 whether or not to retrieve album artwork for each result      � ! ! r   w h e t h e r   o r   n o t   t o   r e t r i e v e   a l b u m   a r t w o r k   f o r   e a c h   r e s u l t   " # " l    $���� $ r     % & % m    ��
�� boovtrue & o      ���� "0 albumartenabled albumArtEnabled��  ��   #  ' ( ' l     ��������  ��  ��   (  ) * ) l     �� + ,��   + 1 + Script parameters (do not change these) --    , � - - V   S c r i p t   p a r a m e t e r s   ( d o   n o t   c h a n g e   t h e s e )   - - *  . / . l     ��������  ��  ��   /  0 1 0 l     �� 2 3��   2   cache variables    3 � 4 4     c a c h e   v a r i a b l e s 1  5 6 5 l    7���� 7 r     8 9 8 l    :���� : I   �� ; <
�� .earsffdralis        afdr ; m    	��
�� afdrcusr < �� =��
�� 
rtyp = m   
 ��
�� 
ctxt��  ��  ��   9 o      ���� 0 
homefolder 
homeFolder��  ��   6  > ? > l    @���� @ r     A B A l    C���� C I   �� D E
�� .earsffdralis        afdr D m    ��
�� afdrdlib E �� F G
�� 
from F m    ��
�� fldmfldu G �� H��
�� 
rtyp H m    ��
�� 
ctxt��  ��  ��   B o      ���� 0 libraryfolder libraryFolder��  ��   ?  I J I l   # K���� K r    # L M L l   ! N���� N b    ! O P O o    ���� 0 libraryfolder libraryFolder P m      Q Q � R R  C a c h e s :��  ��   M o      ���� 0 cachefolder cacheFolder��  ��   J  S T S l  $ + U���� U r   $ + V W V l  $ ' X���� X b   $ ' Y Z Y o   $ %���� 0 cachefolder cacheFolder Z m   % & [ [ � \ \ \ c o m . r u n n i n g w i t h c r a y o n s . A l f r e d - 2 : W o r k f l o w   D a t a :��  ��   W o      ���� (0 workflowdatafolder workflowDataFolder��  ��   T  ] ^ ] l  , 3 _���� _ r   , 3 ` a ` m   , / b b � c c . c o m . c a l e b e v a n s . p l a y s o n g a o      ���� &0 artworkfoldername artworkFolderName��  ��   ^  d e d l  4 C f���� f r   4 C g h g l  4 ? i���� i b   4 ? j k j b   4 ; l m l o   4 7���� (0 workflowdatafolder workflowDataFolder m o   7 :���� &0 artworkfoldername artworkFolderName k m   ; > n n � o o  :��  ��   h o      ���� &0 artworkfolderpath artworkFolderPath��  ��   e  p q p l  D K r���� r r   D K s t s m   D G u u � v v    |   t o      ���� (0 songartworknamesep songArtworkNameSep��  ��   q  w x w l  L S y���� y r   L S z { z m   L O | | � } } $ i c o n - n o a r t w o r k . p n g { o      ���� "0 defaulticonname defaultIconName��  ��   x  ~  ~ l     ��������  ��  ��     � � � l     �� � ���   � 9 3 replace substring in string with another substring    � � � � f   r e p l a c e   s u b s t r i n g   i n   s t r i n g   w i t h   a n o t h e r   s u b s t r i n g �  � � � i      � � � I      �� ����� 0 replace   �  � � � o      ���� 0 replacethis replaceThis �  � � � o      ���� 0 replacewith replaceWith �  ��� � o      ���� 0 originalstr originalStr��  ��   � k      � �  � � � r      � � � o     ���� 0 replacethis replaceThis � n      � � � 1    ��
�� 
txdl � 1    ��
�� 
ascr �  � � � r     � � � n    	 � � � 2   	��
�� 
citm � o    ���� 0 originalstr originalStr � o      ���� 0 stritems strItems �  � � � r     � � � o    ���� 0 replacewith replaceWith � n      � � � 1    ��
�� 
txdl � 1    ��
�� 
ascr �  ��� � L     � � c     � � � o    ���� 0 stritems strItems � m    ��
�� 
ctxt��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � 9 3 escape XML reserved characters in the given string    � � � � f   e s c a p e   X M L   r e s e r v e d   c h a r a c t e r s   i n   t h e   g i v e n   s t r i n g �  � � � i     � � � I      �� �����  0 escapexmlchars escapeXmlChars �  ��� � o      ���� 0 str  ��  ��   � k     # � �  � � � r     
 � � � I     �� ����� 0 replace   �  � � � m     � � � � �  & �  � � � m     � � � � � 
 & a m p ; �  ��� � o    ���� 0 str  ��  ��   � o      ���� 0 str   �  � � � r     � � � I    �� ����� 0 replace   �  � � � m     � � � � �  < �  � � � m     � � � � �  & l t ; �  ��� � o    ���� 0 str  ��  ��   � o      ���� 0 str   �  � � � r      � � � I    �� ����� 0 replace   �  � � � m     � � � � �  > �  � � � m     � � � � �  & g t ; �  ��� � o    ���� 0 str  ��  ��   � o      ���� 0 str   �  ��� � L   ! # � � o   ! "���� 0 str  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � ' ! create Alfred result item as XML    � � � � B   c r e a t e   A l f r e d   r e s u l t   i t e m   a s   X M L �  � � � i     � � � I      � ��~� 0 
createitem 
createItem �  � � � o      �}�} 0 uid   �  � � � o      �|�| 0 arg   �  � � � o      �{�{ 	0 valid   �  � � � o      �z�z 	0 title   �  � � � o      �y�y 0 subtitle   �  ��x � o      �w�w 0 icon  �x  �~   � k     W � �  � � � p       � � �v ��v 0 
homefolder 
homeFolder � �u�t�u "0 defaulticonname defaultIconName�t   �  � � � l     �s�r�q�s  �r  �q   �  � � � l     �p �p    ( " recognize file paths for the icon    � D   r e c o g n i z e   f i l e   p a t h s   f o r   t h e   i c o n �  Z     �o�n C     o     �m�m 0 icon   o    �l�l 0 
homefolder 
homeFolder r    	
	 n    	 1    	�k
�k 
psxp o    �j�j 0 icon  
 o      �i�i 0 icon  �o  �n    l   �h�g�f�h  �g  �f    l   �e�e   %  escape reserved XML characters    � >   e s c a p e   r e s e r v e d   X M L   c h a r a c t e r s  r     I    �d�c�d  0 escapexmlchars escapeXmlChars �b o    �a�a 	0 title  �b  �c   o      �`�` 	0 title    r    ! I    �_�^�_  0 escapexmlchars escapeXmlChars �] o    �\�\ 0 subtitle  �]  �^   o      �[�[ 0 subtitle    !  Z   " 4"#�Z�Y" >  " %$%$ o   " #�X�X 0 icon  % o   # $�W�W "0 defaulticonname defaultIconName# r   ( 0&'& I   ( .�V(�U�V  0 escapexmlchars escapeXmlChars( )�T) o   ) *�S�S 0 icon  �T  �U  ' o      �R�R 0 icon  �Z  �Y  ! *+* l  5 5�Q�P�O�Q  �P  �O  + ,-, L   5 U.. b   5 T/0/ b   5 R121 b   5 P343 b   5 N565 b   5 L787 b   5 J9:9 b   5 H;<; b   5 F=>= b   5 D?@? b   5 BABA b   5 @CDC b   5 >EFE b   5 <GHG b   5 :IJI b   5 8KLK 1   5 6�N
�N 
tab L m   6 7MM �NN  < i t e m   u i d = 'J o   8 9�M�M 0 uid  H m   : ;OO �PP  '   a r g = 'F o   < =�L�L 0 arg  D m   > ?QQ �RR  '   v a l i d = 'B o   @ A�K�K 	0 valid  @ m   B CSS �TT  ' > 
 	 	 < t i t l e >> o   D E�J�J 	0 title  < m   F GUU �VV * < / t i t l e > 
 	 	 < s u b t i t l e >: o   H I�I�I 0 subtitle  8 m   J KWW �XX ( < / s u b t i t l e > 
 	 	 < i c o n >6 o   L M�H�H 0 icon  4 m   N OYY �ZZ   < / i c o n > 
 	 < / i t e m >2 o   P Q�G
�G 
ret 0 o   R S�F
�F 
ret - [�E[ l  V V�D�C�B�D  �C  �B  �E   � \]\ l     �A�@�?�A  �@  �?  ] ^_^ l     �>`a�>  ` / ) get path to album art for the given song   a �bb R   g e t   p a t h   t o   a l b u m   a r t   f o r   t h e   g i v e n   s o n g_ cdc i    efe I      �=g�<�= (0 getsongartworkpath getSongArtworkPathg hih o      �;�; 0 thesong theSongi jkj o      �:�: 0 
songartist 
songArtistk l�9l o      �8�8 0 	songalbum 	songAlbum�9  �<  f k     �mm non p      pp �7q�7 "0 albumartenabled albumArtEnabledq �6r�6 &0 artworkfolderpath artworkFolderPathr �5s�5 &0 artworkfoldername artworkFolderNames �4�3�4 (0 songartworknamesep songArtworkNameSep�3  o tut l     �2�1�0�2  �1  �0  u vwv Z     �xy�/zx =    {|{ o     �.�. "0 albumartenabled albumArtEnabled| m    �-
�- boovfalsy r    	}~} o    �,�, "0 defaulticonname defaultIconName~ o      �+�+ "0 songartworkpath songArtworkPath�/  z k    � ��� l   �*���*  � 2 , generate a unique identifier for that album   � ��� X   g e n e r a t e   a   u n i q u e   i d e n t i f i e r   f o r   t h a t   a l b u m� ��� r    ��� c    ��� l   ��)�(� b    ��� b    ��� o    �'�' 0 
songartist 
songArtist� o    �&�& (0 songartworknamesep songArtworkNameSep� o    �%�% 0 	songalbum 	songAlbum�)  �(  � m    �$
�$ 
ctxt� o      �#�# "0 songartworkname songArtworkName� ��� l   �"���"  � ' ! remove forbidden path characters   � ��� B   r e m o v e   f o r b i d d e n   p a t h   c h a r a c t e r s� ��� r     ��� n    ��� I    �!�� �! 0 replace  � ��� m    �� ���  :� ��� m    �� ���  � ��� o    �� "0 songartworkname songArtworkName�  �   �  f    � o      �� "0 songartworkname songArtworkName� ��� r   ! +��� n   ! )��� I   " )���� 0 replace  � ��� m   " #�� ���  /� ��� m   # $�� ���  � ��� o   $ %�� "0 songartworkname songArtworkName�  �  �  f   ! "� o      �� "0 songartworkname songArtworkName� ��� r   , 6��� n   , 4��� I   - 4���� 0 replace  � ��� m   - .�� ���  .� ��� m   . /�� ���  � ��� o   / 0�� "0 songartworkname songArtworkName�  �  �  f   , -� o      �� "0 songartworkname songArtworkName� ��� r   7 >��� l  7 <���� b   7 <��� b   7 :��� o   7 8�� &0 artworkfolderpath artworkFolderPath� o   8 9�� "0 songartworkname songArtworkName� m   : ;�� ���  . j p g�  �  � o      �� "0 songartworkpath songArtworkPath� ��� l  ? ?����  �  �  � ��
� O   ? ���� k   C ��� ��� l  C C�	���	  � / ) cache artwork if it's not already cached   � ��� R   c a c h e   a r t w o r k   i f   i t ' s   n o t   a l r e a d y   c a c h e d� ��� Z   C ������ H   C I�� l  C H���� I  C H���
� .coredoexbool        obj � o   C D�� "0 songartworkpath songArtworkPath�  �  �  � O   L ���� k   P ��� ��� r   P U��� n   P S��� 2  Q S� 
�  
cArt� o   P Q���� 0 eachsong eachSong� o      ���� 0 songartworks songArtworks� ��� l  V V������  � 8 2 only save artwork if artwork exists for this song   � ��� d   o n l y   s a v e   a r t w o r k   i f   a r t w o r k   e x i s t s   f o r   t h i s   s o n g� ���� Z   V ������� =  V ]��� l  V [������ n   V [��� 1   W [��
�� 
leng� o   V W���� 0 songartworks songArtworks��  ��  � m   [ \����  � k   ` c�� ��� l  ` `������  � 5 / use default iTunes icon if song has no artwork   � ��� ^   u s e   d e f a u l t   i T u n e s   i c o n   i f   s o n g   h a s   n o   a r t w o r k� ���� r   ` c� � o   ` a���� "0 defaulticonname defaultIconName  o      ���� "0 songartworkpath songArtworkPath��  ��  � k   f �  l  f f����     save artwork to file    � *   s a v e   a r t w o r k   t o   f i l e  r   f r	
	 n   f p 1   l p��
�� 
pPCT l  f l���� n   f l 4   g l��
�� 
cobj m   j k����  o   f g���� 0 songartworks songArtworks��  ��  
 o      ���� 0 songartwork songArtwork  r   s ~ I  s |��
�� .rdwropenshor       file o   s t���� "0 songartworkpath songArtworkPath ����
�� 
perm m   w x��
�� boovtrue��   o      ���� 0 fileref fileRef  I   ���
�� .rdwrwritnull���     **** o    ����� 0 songartwork songArtwork ����
�� 
refn o   � ����� 0 fileref fileRef��   �� I  � �����
�� .rdwrclosnull���     **** o   � ����� 0 fileref fileRef��  ��  ��  � m   L M�                                                                                  hook  alis    H  
Caleb's HD                 �l�kH+  ��
iTunes.app                                                     `��Aa�        ����  	                Applications    �m�      �A�    ��  #Caleb's HD:Applications: iTunes.app    
 i T u n e s . a p p   
 C a l e b ' s   H D  Applications/iTunes.app   / ��  �  �  �  � m   ? @  �                                                                                  MACS  alis    n  
Caleb's HD                 �l�kH+  �v
Finder.app                                                     #	�B        ����  	                CoreServices    �m�      �B�    �v�j�i  4Caleb's HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p   
 C a l e b ' s   H D  &System/Library/CoreServices/Finder.app  / ��  �
  w !"! l  � ���������  ��  ��  " #$# L   � �%% o   � ����� "0 songartworkpath songArtworkPath$ &��& l  � ���������  ��  ��  ��  d '(' l     ��������  ��  ��  ( )*) l     ��+,��  + !  create album artwork cache   , �-- 6   c r e a t e   a l b u m   a r t w o r k   c a c h e* ./. i    010 I      �������� (0 createartworkcache createArtworkCache��  ��  1 k     -22 343 p      55 ��6�� "0 albumartenabled albumArtEnabled6 ��7�� &0 artworkfolderpath artworkFolderPath7 ������ (0 workflowdatafolder workflowDataFolder��  4 898 l     ��:;��  : 7 1 create album artwork folder if it does not exist   ; �<< b   c r e a t e   a l b u m   a r t w o r k   f o l d e r   i f   i t   d o e s   n o t   e x i s t9 =��= Z     ->?����> =    @A@ o     ���� "0 albumartenabled albumArtEnabledA m    ��
�� boovtrue? O    )BCB Z   
 (DE����D H   
 FF l  
 G����G I  
 ��H��
�� .coredoexbool        obj H 4   
 ��I
�� 
alisI o    ���� &0 artworkfolderpath artworkFolderPath��  ��  ��  E I   $����J
�� .corecrel****      � null��  J ��KL
�� 
koclK n   MNM m    ��
�� 
cfolN o    ���� (0 workflowdatafolder workflowDataFolderL ��O��
�� 
prdtO K     PP ��Q��
�� 
pnamQ o    ���� &0 artworkfoldername artworkFolderName��  ��  ��  ��  C m    RR�                                                                                  MACS  alis    n  
Caleb's HD                 �l�kH+  �v
Finder.app                                                     #	�B        ����  	                CoreServices    �m�      �B�    �v�j�i  4Caleb's HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p   
 C a l e b ' s   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��  ��  / STS l     ��������  ��  ��  T UVU l     ��WX��  W ) # get song result list as XML string   X �YY F   g e t   s o n g   r e s u l t   l i s t   a s   X M L   s t r i n gV Z[Z i    \]\ I      ��^���� $0 getresultlistxml getResultListXml^ _��_ o      ���� 	0 query  ��  ��  ] k     �`` aba p      cc ��d�� 0 	songlimit 	songLimitd ������ "0 defaulticonname defaultIconName��  b efe l     ��������  ��  ��  f ghg l     ��ij��  i 0 * search iTunes library for the given query   j �kk T   s e a r c h   i T u n e s   l i b r a r y   f o r   t h e   g i v e n   q u e r yh lml O     �non k    �pp qrq l   ��������  ��  ��  r sts l   ��uv��  u 5 / search Music playlist for songs matching query   v �ww ^   s e a r c h   M u s i c   p l a y l i s t   f o r   s o n g s   m a t c h i n g   q u e r yt xyx r    z{z l   |����| I   ��}~
�� .hookSrchcTrk        cPly} 4    ��
�� 
cPly m    ���� ~ �����
�� 
pTrm� o   	 
���� 	0 query  ��  ��  ��  { o      ���� 0 allsongs allSongsy ��� l   ��������  ��  ��  � ��� l   ������  �    create initial XML string   � ��� 4   c r e a t e   i n i t i a l   X M L   s t r i n g� ��� r    ��� b    ��� b    ��� b    ��� b    ��� m    �� ��� * < ? x m l   v e r s i o n = ' 1 . 0 ' ? >� o    ��
�� 
ret � m    �� ���  < i t e m s >� o    ��
�� 
ret � o    ��
�� 
ret � o      ���� 0 xml  � ��� l   ��������  ��  ��  � ��� l   ������  � R L inform user that no results were found (prompt to switch to iTunes instead)   � ��� �   i n f o r m   u s e r   t h a t   n o   r e s u l t s   w e r e   f o u n d   ( p r o m p t   t o   s w i t c h   t o   i T u n e s   i n s t e a d )� ��� Z    ������� =   "��� n     ��� 1     ��
�� 
leng� o    ���� 0 allsongs allSongs� m     !����  � k   % :�� ��� l  % %��������  ��  ��  � ��� r   % 8��� b   % 6��� o   % &���� 0 xml  � n   & 5��� I   ' 5���~� 0 
createitem 
createItem� ��� m   ' (�� ���  n o - r e s u l t s� ��� m   ( )�� ���  n u l l� ��� m   ) *�� ���  n o� ��� m   * +�� ���  N o t   F o u n d� ��� l  + 0��}�|� b   + 0��� b   + .��� m   + ,�� ���   N o   r e s u l t s   f o r   '� o   , -�{�{ 	0 query  � m   . /�� ���  '�}  �|  � ��z� o   0 1�y�y "0 defaulticonname defaultIconName�z  �~  �  f   & '� o      �x�x 0 xml  � ��w� l  9 9�v�u�t�v  �u  �t  �w  ��  � k   = ��� ��� l  = =�s�r�q�s  �r  �q  � ��� r   = @��� m   = >�p�p � o      �o�o 0 	songindex 	songIndex� ��� l  A A�n�m�l�n  �m  �l  � ��� l  A A�k���k  � 6 0 loop through the results to create the XML data   � ��� `   l o o p   t h r o u g h   t h e   r e s u l t s   t o   c r e a t e   t h e   X M L   d a t a� ��� X   A ���j�� k   U ��� ��� l  U U�i�h�g�i  �h  �g  � ��� l  U U�f���f  �   limit number of results   � ��� 0   l i m i t   n u m b e r   o f   r e s u l t s� ��� Z   U b���e�d� ?  U Z��� o   U V�c�c 0 	songindex 	songIndex� o   V Y�b�b 0 	songlimit 	songLimit�  S   ] ^�e  �d  � ��� l  c c�a�`�_�a  �`  �_  � ��� l  c c�^���^  �   get song information   � ��� *   g e t   s o n g   i n f o r m a t i o n� ��� r   c k��� l  c i��]�\� e   c i�� n   c i��� 1   d h�[
�[ 
pDID� o   c d�Z�Z 0 eachsong eachSong�]  �\  � o      �Y�Y 0 songid songId�    r   l s n   l q 1   m q�X
�X 
pnam o   l m�W�W 0 eachsong eachSong o      �V�V 0 songname songName  r   t {	 n   t y

 1   u y�U
�U 
pArt o   t u�T�T 0 eachsong eachSong	 o      �S�S 0 
songartist 
songArtist  r   | � n   | � 1   } ��R
�R 
pAlb o   | }�Q�Q 0 eachsong eachSong o      �P�P 0 	songalbum 	songAlbum  r   � � n   � � 1   � ��O
�O 
pKnd o   � ��N�N 0 eachsong eachSong o      �M�M 0 songkind songKind  l  � ��L�K�J�L  �K  �J    l  � ��I�I   "  filter out digital booklets    � 8   f i l t e r   o u t   d i g i t a l   b o o k l e t s   Z   � �!"�H�G! >  � �#$# o   � ��F�F 0 songkind songKind$ m   � �%% �&&  P D F   D o c u m e n t" k   � �'' ()( l  � ��E�D�C�E  �D  �C  ) *+* r   � �,-, n   � �./. I   � ��B0�A�B (0 getsongartworkpath getSongArtworkPath0 121 o   � ��@�@ 0 eachsong eachSong2 343 o   � ��?�? 0 
songartist 
songArtist4 5�>5 o   � ��=�= 0 	songalbum 	songAlbum�>  �A  /  f   � �- o      �<�< "0 songartworkpath songArtworkPath+ 676 l  � ��;�:�9�;  �:  �9  7 898 l  � ��8:;�8  : "  add song information to XML   ; �<< 8   a d d   s o n g   i n f o r m a t i o n   t o   X M L9 =>= r   � �?@? b   � �ABA o   � ��7�7 0 xml  B n   � �CDC I   � ��6E�5�6 0 
createitem 
createItemE FGF l  � �H�4�3H b   � �IJI m   � �KK �LL  t r a c k -J o   � ��2�2 0 songid songId�4  �3  G MNM o   � ��1�1 0 songid songIdN OPO m   � �QQ �RR  y e sP STS o   � ��0�0 0 songname songNameT UVU o   � ��/�/ 0 
songartist 
songArtistV W�.W o   � ��-�- "0 songartworkpath songArtworkPath�.  �5  D  f   � �@ o      �,�, 0 xml  > XYX l  � ��+�*�)�+  �*  �)  Y Z[Z r   � �\]\ [   � �^_^ o   � ��(�( 0 	songindex 	songIndex_ m   � ��'�' ] o      �&�& 0 	songindex 	songIndex[ `�%` l  � ��$�#�"�$  �#  �"  �%  �H  �G    a�!a l  � �� ���   �  �  �!  �j 0 eachsong eachSong� o   D E�� 0 allsongs allSongs� b�b l  � �����  �  �  �  � cdc l  � �����  �  �  d efe r   � �ghg b   � �iji o   � ��� 0 xml  j m   � �kk �ll  < / i t e m s >h o      �� 0 xml  f m�m l  � �����  �  �  �  o m     nn�                                                                                  hook  alis    H  
Caleb's HD                 �l�kH+  ��
iTunes.app                                                     `��Aa�        ����  	                Applications    �m�      �A�    ��  #Caleb's HD:Applications: iTunes.app    
 i T u n e s . a p p   
 C a l e b ' s   H D  Applications/iTunes.app   / ��  m opo l  � �����  �  �  p qrq l  � ��st�  s   return XML data   t �uu     r e t u r n   X M L   d a t ar vwv L   � �xx o   � ��� 0 xml  w y�
y l  � ��	���	  �  �  �
  [ z{z l     ����  �  �  { |}| l  T Y~��~ I   T Y�� ��� (0 createartworkcache createArtworkCache�   ��  �  �  } �� l  Z b������ I   Z b������� $0 getresultlistxml getResultListXml� ���� m   [ ^�� ���  { q u e r y }��  ��  ��  ��  ��       ������������������ b� u |������������������������  � ���������������������������������������������������������� 0 replace  ��  0 escapexmlchars escapeXmlChars�� 0 
createitem 
createItem�� (0 getsongartworkpath getSongArtworkPath�� (0 createartworkcache createArtworkCache�� $0 getresultlistxml getResultListXml
�� .aevtoappnull  �   � ****�� 0 	songlimit 	songLimit�� "0 albumartenabled albumArtEnabled�� 0 
homefolder 
homeFolder�� 0 libraryfolder libraryFolder�� 0 cachefolder cacheFolder�� (0 workflowdatafolder workflowDataFolder�� &0 artworkfoldername artworkFolderName�� &0 artworkfolderpath artworkFolderPath�� (0 songartworknamesep songArtworkNameSep�� "0 defaulticonname defaultIconName��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  � �� ����������� 0 replace  �� ����� �  �������� 0 replacethis replaceThis�� 0 replacewith replaceWith�� 0 originalstr originalStr��  � ���������� 0 replacethis replaceThis�� 0 replacewith replaceWith�� 0 originalstr originalStr�� 0 stritems strItems� ��������
�� 
ascr
�� 
txdl
�� 
citm
�� 
ctxt�� ���,FO��-E�O���,FO��&� �� �����������  0 escapexmlchars escapeXmlChars�� ����� �  ���� 0 str  ��  � ���� 0 str  �  � ��� � � � ��� 0 replace  �� $*��m+ E�O*��m+ E�O*��m+ E�O�� �� ����������� 0 
createitem 
createItem�� ����� �  �������������� 0 uid  �� 0 arg  �� 	0 valid  �� 	0 title  �� 0 subtitle  �� 0 icon  ��  � �������������� 0 uid  �� 0 arg  �� 	0 valid  �� 	0 title  �� 0 subtitle  �� 0 icon  � ����������MOQSUWY���� 0 
homefolder 
homeFolder
�� 
psxp��  0 escapexmlchars escapeXmlChars�� "0 defaulticonname defaultIconName
�� 
tab 
�� 
ret �� X�� 
��,E�Y hO*�k+ E�O*�k+ E�O�� *�k+ E�Y hO��%�%�%�%�%�%�%�%�%�%�%�%�%�%�%OP� ��f���������� (0 getsongartworkpath getSongArtworkPath�� ����� �  �������� 0 thesong theSong�� 0 
songartist 
songArtist�� 0 	songalbum 	songAlbum��  � 
���������������������� 0 thesong theSong�� 0 
songartist 
songArtist�� 0 	songalbum 	songAlbum�� "0 defaulticonname defaultIconName�� "0 songartworkpath songArtworkPath�� "0 songartworkname songArtworkName�� 0 eachsong eachSong�� 0 songartworks songArtworks�� 0 songartwork songArtwork�� 0 fileref fileRef� ����������������� ��������������������� "0 albumartenabled albumArtEnabled�� (0 songartworknamesep songArtworkNameSep
�� 
ctxt�� 0 replace  �� &0 artworkfolderpath artworkFolderPath
�� .coredoexbool        obj 
�� 
cArt
�� 
leng
�� 
cobj
�� 
pPCT
�� 
perm
�� .rdwropenshor       file
�� 
refn
�� .rdwrwritnull���     ****
� .rdwrclosnull���     ****�� ��f  �E�Y ���%�%�&E�O)��m+ E�O)��m+ E�O)��m+ E�Oʥ%�%E�O� R�j  H� @��-E�O�a ,j  �E�Y *�a k/a ,E�O�a el E�O�a �l O�j UY hUO�OP� �~1�}�|���{�~ (0 createartworkcache createArtworkCache�}  �|  � �z�z &0 artworkfoldername artworkFolderName� �yR�x�w�v�u�t�s�r�q�p�o�y "0 albumartenabled albumArtEnabled
�x 
alis�w &0 artworkfolderpath artworkFolderPath
�v .coredoexbool        obj 
�u 
kocl�t (0 workflowdatafolder workflowDataFolder
�s 
cfol
�r 
prdt
�q 
pnam�p 
�o .corecrel****      � null�{ .�e  (�  *��/j  *���,��l� Y hUY h� �n]�m�l���k�n $0 getresultlistxml getResultListXml�m �j��j �  �i�i 	0 query  �l  � �h�g�f�e�d�c�b�a�`�_�^�h 	0 query  �g 0 allsongs allSongs�f 0 xml  �e 0 	songindex 	songIndex�d 0 eachsong eachSong�c 0 songid songId�b 0 songname songName�a 0 
songartist 
songArtist�` 0 	songalbum 	songAlbum�_ 0 songkind songKind�^ "0 songartworkpath songArtworkPath� n�]�\�[��Z��Y�������X�W�V�U�T�S�R�Q�P�O�N�M%�LKQk
�] 
cPly
�\ 
pTrm
�[ .hookSrchcTrk        cPly
�Z 
ret 
�Y 
leng�X "0 defaulticonname defaultIconName�W �V 0 
createitem 
createItem
�U 
kocl
�T 
cobj
�S .corecnte****       ****�R 0 	songlimit 	songLimit
�Q 
pDID
�P 
pnam
�O 
pArt
�N 
pAlb
�M 
pKnd�L (0 getsongartworkpath getSongArtworkPath�k �� �*�l/�l E�O��%�%�%�%E�O��,j  �)�����%�%��+ %E�OPY �kE�O ��[a a l kh �_  Y hO�a ,EE�O�a ,E�O�a ,E�O�a ,E�O�a ,E�O�a  -)���m+ E�O�)a �%�a ����+ %E�O�kE�OPY hOP[OY��OPO�a %E�OPUO�OP� �K��J�I���H
�K .aevtoappnull  �   � ****� k     b��  ��  "��  5��  >��  I��  S��  ]��  d��  p��  w�� |�� �G�G  �J  �I  �  � �F�E�D�C�B�A�@�?�>�=�<�;�: Q�9 [�8 b�7 n�6 u�5 |�4�3��2�F 	�E 0 	songlimit 	songLimit�D "0 albumartenabled albumArtEnabled
�C afdrcusr
�B 
rtyp
�A 
ctxt
�@ .earsffdralis        afdr�? 0 
homefolder 
homeFolder
�> afdrdlib
�= 
from
�< fldmfldu�; �: 0 libraryfolder libraryFolder�9 0 cachefolder cacheFolder�8 (0 workflowdatafolder workflowDataFolder�7 &0 artworkfoldername artworkFolderName�6 &0 artworkfolderpath artworkFolderPath�5 (0 songartworknamesep songArtworkNameSep�4 "0 defaulticonname defaultIconName�3 (0 createartworkcache createArtworkCache�2 $0 getresultlistxml getResultListXml�H c�E�OeE�O���l E�O������ E�O��%E�O��%E` Oa E` O_ _ %a %E` Oa E` Oa E` O*j+ O*a k+ �� 	
�� boovtrue� ��� . C a l e b ' s   H D : U s e r s : C a l e b :� ��� > C a l e b ' s   H D : U s e r s : C a l e b : L i b r a r y :� ��� L C a l e b ' s   H D : U s e r s : C a l e b : L i b r a r y : C a c h e s :� ��� � C a l e b ' s   H D : U s e r s : C a l e b : L i b r a r y : C a c h e s : c o m . r u n n i n g w i t h c r a y o n s . A l f r e d - 2 : W o r k f l o w   D a t a :� ��� � C a l e b ' s   H D : U s e r s : C a l e b : L i b r a r y : C a c h e s : c o m . r u n n i n g w i t h c r a y o n s . A l f r e d - 2 : W o r k f l o w   D a t a : c o m . c a l e b e v a n s . p l a y s o n g :��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��   ascr  ��ޭ