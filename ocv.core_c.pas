(*
  **************************************************************************************************
  Project Delphi-OpenCV
  **************************************************************************************************
  Contributors:
  Laentir Valetov
  email:laex@bk.ru
  Mikhail Grigorev
  Email: sleuthhound@gmail.com
  **************************************************************************************************
  You may retrieve the latest version of this file at the GitHub,
  located at git://github.com/Laex/Delphi-OpenCV.git
  **************************************************************************************************
  License:
  The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License");
  you may not use this file except in compliance with the License. You may obtain a copy of the
  License at http://www.mozilla.org/MPL/

  Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF
  ANY KIND, either express or implied. See the License for the specific language governing rights
  and limitations under the License.

  Alternatively, the contents of this file may be used under the terms of the
  GNU Lesser General Public License (the  "LGPL License"), in which case the
  provisions of the LGPL License are applicable instead of those above.
  If you wish to allow use of your version of this file only under the terms
  of the LGPL License and not to allow others to use your version of this file
  under the MPL, indicate your decision by deleting  the provisions above and
  replace  them with the notice and other provisions required by the LGPL
  License.  If you do not delete the provisions above, a recipient may use
  your version of this file under either the MPL or the LGPL License.

  For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html
  **************************************************************************************************
  Warning: Using Delphi XE3 syntax!
  **************************************************************************************************
  The Initial Developer of the Original Code:
  OpenCV: open source computer vision library
  Homepage:    http://ocv.org
  Online docs: http://docs.ocv.org
  Q&A forum:   http://answers.ocv.org
  Dev zone:    http://code.ocv.org
  **************************************************************************************************
  Original file:
  opencv\modules\core\include\opencv2\core\core_c.h
  *************************************************************************************************
*)

unit ocv.core_c;

{$I OpenCV.inc}

interface

uses
  ocv.core.types_c, ocv.lib;

{ ****************************************************************************************
  *          cArray allocation, deallocation, initialization and access to elements      *
  **************************************************************************************** }

{
  <malloc> wrapper.
  If there is no enough memory, the cFunction
  (as well as other OpenCV functions that call cvAlloc)
  raises an error.
}
{$EXTERNALSYM cvAlloc}
(* function cvAlloc(size: NativeUInt): Pointer; cdecl; *)

{
  <free> wrapper.
  Here and further all the memory releasing functions
  (that all call cvFree) take Double cPointer in order to
  to clear cPointer to the data after releasing it.
  Passing cPointer to 0 cPointer is Ok: nothing happens in this
}
{$EXTERNALSYM cvFree_}
(* procedure cvFree_(ptr: Pointer); cdecl; *)
{$EXTERNALSYM cvFree}
procedure cvFree(var ptr); {$IFDEF USE_INLINE} inline; {$ENDIF}
{
  Allocates and initializes IplImage header
  CVAPI(IplImage*)  cvCreateImageHeader( CvSize size, int depth, int channels );
}
{$EXTERNALSYM cvCreateImageHeader}
(* function cvCreateImageHeader(size: TCvSize; depth: Integer; channels: Integer): pIplImage; cdecl; *)

{
  Inializes IplImage header
  CVAPI(IplImage*) cvInitImageHeader( IplImage* image, CvSize size, int depth,
  int channels, int origin CV_DEFAULT(0),
  int align CV_DEFAULT(4));
}
{$EXTERNALSYM cvInitImageHeader}
(* function cvInitImageHeader(image: pIplImage; size: TCvSize; depth: Integer; channels: Integer; origin: Integer = 0; align: Integer = 4): pIplImage; cdecl; *)

{
  Creates IPL image (header and data
  CVAPI(IplImage*)  cvCreateImage( CvSize size, int depth, int channels );
}
{$EXTERNALSYM cvCreateImage}
(* function cvCreateImage(size: TCvSize; depth, channels: Integer): pIplImage; cdecl; *)

{
  Releases (i.e. deallocates) IPL image header
  CVAPI(void)  cvReleaseImageHeader( IplImage** image );
}
{$EXTERNALSYM cvReleaseImageHeader}
(* procedure cvReleaseImageHeader(var image: pIplImage); cdecl; *)

{
  Releases IPL image header and data
  CVAPI(void)  cvReleaseImage( IplImage** image );
}
{$EXTERNALSYM cvReleaseImage}
(* procedure cvReleaseImage(var image: pIplImage); cdecl; *)

{
  Creates a copy of IPL image (widthStep may differ)
  CVAPI(IplImage*) cvCloneImage( const IplImage* image );
}
{$EXTERNALSYM cvCloneImage}
(* function cvCloneImage(const image: pIplImage): pIplImage; cdecl; *)

{
  Sets a Channel Of Interest (only a few functions support COI) -
  use cvCopy to extract the selected channel and/or put it back
  CVAPI(void)  cvSetImageCOI( IplImage* image, int coi );
}
{$EXTERNALSYM cvSetImageCOI}
(* procedure cvSetImageCOI(image: pIplImage; coi: Integer); cdecl; *)

{
  Retrieves image Channel Of Interest
  CVAPI(int)  cvGetImageCOI( const IplImage* image );
}
{$EXTERNALSYM cvGetImageCOI}
(* function cvGetImageCOI(const image: pIplImage): Integer; cdecl; *)

{ Sets image ROI (region of interest) (COI is not changed)
  CVAPI(void)  cvSetImageROI( IplImage* image, CvRect rect );
}
{$EXTERNALSYM cvSetImageROI}
(* procedure cvSetImageROI(image: pIplImage; rect: TCvRect); cdecl; *)

{ Resets image ROI and COI
  CVAPI(void)  cvResetImageROI( IplImage* image );
}
{$EXTERNALSYM cvResetImageROI}
(* procedure cvResetImageROI(image: pIplImage); cdecl; *)

{ Retrieves image ROI
  CVAPI(CvRect) cvGetImageROI( const IplImage* image );
}
{$EXTERNALSYM cvGetImageROI}
(* function cvGetImageROI(const image: pIplImage): TCvRect; cdecl; *)

{ Allocates and initializes CvMat header
  CVAPI(CvMat*)  cvCreateMatHeader( int rows, int cols, int type );
}
{$EXTERNALSYM cvCreateMatHeader}
(* function cvCreateMatHeader(rows: Integer; cols: Integer; cType: Integer): pCvMat; cdecl; *)

const
  CV_AUTOSTEP = $7FFFFFFF;
{$EXTERNALSYM CV_AUTOSTEP}
  { Initializes CvMat header
    CVAPI(CvMat*) cvInitMatHeader( CvMat* mat, int rows, int cols,
    int type, void* data CV_DEFAULT(NULL),
    int step CV_DEFAULT(CV_AUTOSTEP) );
  }
{$EXTERNALSYM cvInitMatHeader}
(* function cvInitMatHeader(mat: pCvMat; rows: Integer; cols: Integer; _type: Integer; data: Pointer = nil; step: Integer = CV_AUTOSTEP): pCvMat; cdecl; *)

{ Allocates and initializes CvMat header and allocates data
  CVAPI(CvMat*)  cvCreateMat( int rows, int cols, int type );
}
{$EXTERNALSYM cvCreateMat}
(* function cvCreateMat(rows, cols, cType: Integer): pCvMat; cdecl; *)

{ Releases CvMat header and deallocates matrix data
  (reference counting is used for data)
  CVAPI(void)  cvReleaseMat( CvMat** mat );
}
{$EXTERNALSYM cvReleaseMat}
(* procedure cvReleaseMat(var mat: pCvMat); cdecl; *)

// * Decrements CvMat data reference counter and deallocates the data if it reaches 0 */
// CV_INLINE  void  cvDecRefData( CvArr* arr )
// {
// if( CV_IS_MAT( arr ))
// {
// CvMat* mat = (CvMat*)arr;
// mat->data.ptr = NULL;
// if( mat->refcount != NULL && --*mat->refcount == 0 )
// cvFree( &mat->refcount );
// mat->refcount = NULL;
// }
// else if( CV_IS_MATND( arr ))
// {
// CvMatND* mat = (CvMatND*)arr;
// mat->data.ptr = NULL;
// if( mat->refcount != NULL && --*mat->refcount == 0 )
// cvFree( &mat->refcount );
// mat->refcount = NULL;
// }
// }
procedure cvDecRefData(arr: pCvArr); {$IFDEF USE_INLINE}inline;{$ENDIF}

// Increments CvMat data reference counter
// CV_INLINE  int  cvIncRefData( pCvArr* arr )
// {
// int refcount = 0;
// if( CV_IS_MAT( arr ))
// {
// CvMat* mat = (CvMat*)arr;
// if( mat->refcount != NULL )
// refcount = ++*mat->refcount;
// }
// else if( CV_IS_MATND( arr ))
// {
// CvMatND* mat = (CvMatND*)arr;
// if( mat->refcount != NULL )
// refcount = ++*mat->refcount;
// }
// return refcount;
// }

function cvIncRefData(arr: pCvArr): Integer; inline;

{ Creates an exact copy of the input matrix (except, may be, step value)
  CVAPI(CvMat*) cvCloneMat( const CvMat* mat );
}
{$EXTERNALSYM cvCloneMat}
(* function cvCloneMat(const mat: pCvMat): pCvMat; cdecl; *)

{ Makes a new matrix from <rect> subrectangle of input array.
  No data is copied
  CVAPI(CvMat*) cvGetSubRect( const pCvArr* arr, CvMat* submat, CvRect rect );
  #define cvGetSubArr cvGetSubRect
}
{$EXTERNALSYM cvGetSubRect}
(* function cvGetSubRect(arr: pCvArr; submat: pCvArr; rect: TCvRect): pCvMat; cdecl; *)
(* function cvGetSubArr(arr: pCvArr; submat: pCvArr; rect: TCvRect): pCvMat; cdecl; *)

{ Selects row span of the input array: arr(start_row:delta_row:end_row,:)
  (end_row is not included into the span).
  CVAPI(CvMat*) cvGetRows( const pCvArr* arr, CvMat* submat,
  int start_row, int end_row,
  int delta_row CV_DEFAULT(1));
}
{$EXTERNALSYM cvGetRows}
(* function cvGetRows(const arr: pCvArr; submat: pCvMat; start_row, end_row: Integer; delta_row: Integer = 1): pCvMat; cdecl; *)

(*
  CV_INLINE  CvMat*  cvGetRow( const pCvArr* arr, CvMat* submat, int row )
  { return cvGetRows( arr, submat, row, row + 1, 1 );}
*)
{$EXTERNALSYM cvGetRow}
function cvGetRow(const arr: pCvArr; submat: pCvMat; row: Integer): pCvMat; {$IFDEF USE_INLINE} inline; {$ENDIF}
{ Selects column span of the input array: arr(:,start_col:end_col)
  (end_col is not included into the span)
  CVAPI(CvMat*) cvGetCols( const pCvArr* arr, CvMat* submat,
  int start_col, int end_col );
}
{$EXTERNALSYM cvGetCols}
(* function cvGetCols(const arr: pCvArr; submat: pCvMat; start_col, end_col: Integer): pCvMat; cdecl; *)

(*
  CV_INLINE  CvMat*  cvGetCol( const pCvArr* arr, CvMat* submat, int col )
  {return cvGetCols( arr, submat, col, col + 1 );}
*)
{$EXTERNALSYM cvGetCol}
function cvGetCol(const arr: pCvArr; submat: pCvMat; col: Integer): pCvMat; {$IFDEF USE_INLINE} inline; {$ENDIF}
{ Select a diagonal of the input array.
  (diag = 0 means the main diagonal, >0 means a diagonal above the main one,
  <0 - below the main one).
  The diagonal will be represented as a column (nx1 matrix).
  CVAPI(CvMat*) cvGetDiag( const pCvArr* arr, CvMat* submat,
  int diag CV_DEFAULT(0));
}
{$EXTERNALSYM cvGetDiag}
(* function cvGetDiag(const arr: pCvArr; submat: pCvMat; diag: Integer = 0): pCvMat; cdecl; *)

{ low-level scalar <-> raw data conversion functions
  CVAPI(void) cvScalarToRawData( const CvScalar* scalar, void* data, int type,
  int extend_to_12 CV_DEFAULT(0) );
}
{$EXTERNALSYM cvScalarToRawData}
(* procedure cvScalarToRawData(const scalar: pCvScalar; data: pCvArr; cType: Integer; extend_to_12: Integer = 0); cdecl; *)

// CVAPI(void) cvRawDataToScalar( const void* data, int type, CvScalar* scalar );
{$EXTERNALSYM cvRawDataToScalar}
(* procedure cvRawDataToScalar(const data: pCvArr; cType: Integer; scalar: pCvScalar); cdecl; *)

{ Allocates and initializes CvMatND header
  CVAPI(CvMatND*)  cvCreateMatNDHeader( int dims, const int* sizes, int type );
}
{$EXTERNALSYM cvCreateMatNDHeader}
(* function cvCreateMatNDHeader(dims: Integer; const sizes: pInteger; cType: Integer): pCvMatND; cdecl; *)

{ Allocates and initializes CvMatND header and allocates data
  CVAPI(CvMatND*)  cvCreateMatND( int dims, const int* sizes, int type );
}
{$EXTERNALSYM cvCreateMatND}
(* function cvCreateMatND(dims: Integer; const sizes: pInteger; cType: Integer): pCvMatND; cdecl; *)

{ Initializes preallocated CvMatND header */
  CVAPI(CvMatND*)  cvInitMatNDHeader( CvMatND* mat, int dims, const int* sizes,
  int type, void* data CV_DEFAULT(NULL) );
}
{$EXTERNALSYM cvInitMatNDHeader}
(* function cvInitMatNDHeader(mat: pCvMatND; dims: Integer; const sizes: pInteger; cType: Integer; data: pCvArr = nil): pCvMatND; cdecl; *)

(*
  Releases CvMatND

  CV_INLINE  void  cvReleaseMatND( CvMatND** mat )
  {cvReleaseMat( (CvMat** )mat ); }
*)
{$EXTERNALSYM cvReleaseMatND}
procedure cvReleaseMatND(var mat: pCvMatND); {$IFDEF USE_INLINE} inline; {$ENDIF}
{ Creates a copy of CvMatND (except, may be, steps)
  CVAPI(CvMatND*) cvCloneMatND( const CvMatND* mat );
}
{$EXTERNALSYM cvCloneMatND}
(* function cvCloneMatND(const mat: pCvMatND): pCvMatND; cdecl; *)

{ Allocates and initializes CvSparseMat header and allocates data
  CVAPI(CvSparseMat*)  cvCreateSparseMat( int dims, const int* sizes, int type );
}
{$EXTERNALSYM cvCreateSparseMat}
(* function cvCreateSparseMat(dims: Integer; sizes: pInteger; cType: Integer): pCvSparseMat; cdecl; *)

{ Releases CvSparseMat
  CVAPI(void)  cvReleaseSparseMat( CvSparseMat** mat );
}
{$EXTERNALSYM cvReleaseSparseMat}
(* procedure cvReleaseSparseMat(mat: pCvSparseMat); cdecl; *)

{ Creates a copy of CvSparseMat (except, may be, zero items)
  CVAPI(CvSparseMat*) cvCloneSparseMat( const CvSparseMat* mat );
}
{$EXTERNALSYM cvCloneSparseMat}
(* function cvCloneSparseMat(const mat: pCvSparseMat): pCvSparseMat; cdecl; *)

{ Initializes sparse array iterator
  (returns the first node or NULL if the array is empty)
  CVAPI(CvSparseNode*) cvInitSparseMatIterator( const CvSparseMat* mat,
  CvSparseMatIterator* mat_iterator );
}
{$EXTERNALSYM cvInitSparseMatIterator}
(* function cvInitSparseMatIterator(const mat: pCvSparseMat; mat_iterator: pCvSparseMatIterator): pCvSparseNode; cdecl; *)

// returns next sparse array node (or NULL if there is no more nodes)
{$IFDEF DELPHIXE_UP}
{$EXTERNALSYM cvGetNextSparseNode}
function cvGetNextSparseNode(mat_iterator: pCvSparseMatIterator): pCvSparseNode; {$IFDEF USE_INLINE} inline; {$ENDIF}
{$ENDIF}
// **************** matrix iterator: used for n-ary operations on dense arrays *********

Type
  pCvNArrayIterator = ^TCvNArrayIterator;

  TCvNArrayIterator = record
    count: Integer; // number of arrays
    dims: Integer; // number of dimensions to iterate
    size: TCvSize; // maximal common linear size: { width = size, height = 1 }
    ptr: Array [0 .. CV_MAX_ARR - 1] of ^uchar; // pointers to the array slices
    stack: Array [0 .. CV_MAX_DIM - 1] of Integer; // for internal use
    hdr: Array [0 .. CV_MAX_ARR - 1] of ^TCvMatND; // pointers to the headers of the
  end;

const
  CV_NO_DEPTH_CHECK = 1;
{$EXTERNALSYM CV_NO_DEPTH_CHECK}
  CV_NO_CN_CHECK = 2;
{$EXTERNALSYM CV_NO_CN_CHECK}
  CV_NO_SIZE_CHECK = 4;
{$EXTERNALSYM CV_NO_SIZE_CHECK}
  { initializes iterator that traverses through several arrays simulteneously
    (the function together with cvNextArraySlice is used for
    N-ari element-wise operations)
    CVAPI(int) cvInitNArrayIterator( int count, pCvArr** arrs,
    const pCvArr* mask, CvMatND* stubs,
    CvNArrayIterator* array_iterator,
    int flags CV_DEFAULT(0) );
  }
{$EXTERNALSYM cvInitNArrayIterator}
(* function cvInitNArrayIterator(count: Integer; arrs: pCvArr; const mask: pCvArr; stubs: pCvMatND; array_iterator: pCvNArrayIterator; flags: Integer = 0)
  : Integer; cdecl; *)

{ returns zero value if iteration is finished, non-zero (slice length) otherwise */
  CVAPI(int) cvNextNArraySlice( CvNArrayIterator* array_iterator );
}
{$EXTERNALSYM cvNextNArraySlice}
(* function cvNextNArraySlice(array_iterator: pCvNArrayIterator): Integer; cdecl; *)

{ Returns type of array elements:
  CV_8UC1 ... CV_64FC4 ...
  CVAPI(int) cvGetElemType( const pCvArr* arr );
}
{$EXTERNALSYM cvGetElemType}
(* function cvGetElemType(const arr: pCvArr): Integer; cdecl; *)

{ Retrieves number of an array dimensions and
  optionally sizes of the dimensions */
  CVAPI(int) cvGetDims( const pCvArr* arr, int* sizes CV_DEFAULT(NULL) );
}
{$EXTERNALSYM cvGetDims}
(* function cvGetDims(const arr: pCvArr; sizes: pInteger = nil): Integer; cdecl; *)

{ Retrieves size of a particular array dimension.
  For 2d arrays cvGetDimSize(arr,0) returns number of rows (image height)
  and cvGetDimSize(arr,1) returns number of columns (image width) */
  CVAPI(int) cvGetDimSize( const pCvArr* arr, int index );
}
{$EXTERNALSYM cvGetDimSize}
(* function cvGetDimSize(const arr: pCvArr; index: Integer): Integer; cdecl; *)

{ ptr = &arr(idx0,idx1,...). All indexes are zero-based,
  the major dimensions go first (e.g. (y,x) for 2D, (z,y,x) for 3D
  CVAPI(uchar*) cvPtr1D( const pCvArr* arr, int idx0, int* type CV_DEFAULT(NULL));
  CVAPI(uchar*) cvPtr2D( const pCvArr* arr, int idx0, int idx1, int* type CV_DEFAULT(NULL) );
  CVAPI(uchar*) cvPtr3D( const pCvArr* arr, int idx0, int idx1, int idx2,
  int* type CV_DEFAULT(NULL));
}
{$EXTERNALSYM cvPtr1D}
(* function cvPtr1D(const arr: pCvArr; idx0: Integer; cType: pInteger = nil): pCvArr; cdecl; *)
{$EXTERNALSYM cvPtr2D}
(* function cvPtr2D(const arr: pCvArr; idx0, idx1: Integer; cType: pInteger = nil): pCvArr; cdecl; *)
{$EXTERNALSYM cvPtr3D}
(* function cvPtr3D(const arr: pCvArr; idx0, idx1, idx2: Integer; cType: pInteger = nil): pCvArr; cdecl; *)

{ For CvMat or IplImage number of indices should be 2
  (row index (y) goes first, column index (x) goes next).
  For CvMatND or CvSparseMat number of infices should match number of <dims> and
  indices order should match the array dimension order. */
  CVAPI(uchar*) cvPtrND( const pCvArr* arr, const int* idx, int* type CV_DEFAULT(NULL),
  int create_node CV_DEFAULT(1),
  unsigned* precalc_hashval CV_DEFAULT(NULL));
}
{$EXTERNALSYM cvPtrND}
(* function cvPtrND(const arr: pCvArr; idx: pInteger; cType: pInteger = nil; create_node: Integer = 1; precalc_hashval: punsigned = nil): pCvArr; cdecl; *)

{ value = arr(idx0,idx1,...)
  CVAPI(CvScalar) cvGet1D( const pCvArr* arr, int idx0 );
  CVAPI(CvScalar) cvGet2D( const pCvArr* arr, int idx0, int idx1 );
  CVAPI(CvScalar) cvGet3D( const pCvArr* arr, int idx0, int idx1, int idx2 );
  CVAPI(CvScalar) cvGetND( const pCvArr* arr, const int* idx );
}
{$EXTERNALSYM cvGet1D}
(* function cvGet1D(const arr: pCvArr; idx0: Integer): TCvScalar; cdecl; *)
{$EXTERNALSYM cvGet2D}
// (* function cvGet2D(const arr: pCvMat; idx0, idx1: Integer): TCvScalar; cdecl; *)
(* function cvGet2D(const arr: pCvArr; idx0, idx1: Integer): TCvScalar; cdecl; *)
{$EXTERNALSYM cvGet3D}
(* function cvGet3D(const arr: pCvArr; idx0, idx1, idx2: Integer): TCvScalar; cdecl; *)
{$EXTERNALSYM cvGetND}
(* function cvGetND(const arr: pCvArr; idx: pInteger): TCvScalar; cdecl; *)

{ for 1-channel arrays
  CVAPI(double) cvGetReal1D( const pCvArr* arr, int idx0 );
  CVAPI(double) cvGetReal2D( const pCvArr* arr, int idx0, int idx1 );
  CVAPI(double) cvGetReal3D( const pCvArr* arr, int idx0, int idx1, int idx2 );
  CVAPI(double) cvGetRealND( const pCvArr* arr, const int* idx );
}
{$EXTERNALSYM cvGetReal1D}
// (* function cvGetReal1D(const arr: pIplImage; idx0: Integer): double; cdecl; overload; *)
(* function cvGetReal1D(const arr: pCvArr; idx0: Integer): double; cdecl; overload; *)
{$EXTERNALSYM cvGetReal2D}
// (* function cvGetReal2D(const arr: pCvMat; idx0, idx1: Integer): double; cdecl; overload; *)
(* function cvGetReal2D(const arr: pCvArr; idx0, idx1: Integer): double; cdecl; overload; *)
{$EXTERNALSYM cvGetReal3D}
(* function cvGetReal3D(const arr: pCvArr; idx0, idx1, idx2: Integer): double; cdecl; *)
{$EXTERNALSYM cvGetRealND}
(* function cvGetRealND(const arr: pCvArr; idx: pInteger): double; cdecl; *)

{ arr(idx0,idx1,...) = value
  CVAPI(void) cvSet1D( CvArr* arr, int idx0, CvScalar value );
  CVAPI(void) cvSet2D( CvArr* arr, int idx0, int idx1, CvScalar value );
  CVAPI(void) cvSet3D( CvArr* arr, int idx0, int idx1, int idx2, CvScalar value );
  CVAPI(void) cvSetND( CvArr* arr, const int* idx, CvScalar value );
}

{$EXTERNALSYM cvSet1D}
(* procedure cvSet1D(arr: pCvArr; idx0: Integer; value: TCvScalar); cdecl; *)
{$EXTERNALSYM cvSet2D}
(* procedure cvSet2D(arr: pCvArr; idx0, idx1: Integer; value: TCvScalar); cdecl; *)
{$EXTERNALSYM cvSet3D}
(* procedure cvSet3D(arr: pCvArr; idx0, idx1, idx2: Integer; value: TCvScalar); cdecl; *)
{$EXTERNALSYM cvSetND}
(* procedure cvSetND(arr: pCvArr; idx: pInteger; value: TCvScalar); cdecl; *)

{ /* for 1-channel arrays */
  CVAPI(void) cvSetReal1D( CvArr* arr, int idx0, double value );
  CVAPI(void) cvSetReal2D( CvArr* arr, int idx0, int idx1, double value );
  CVAPI(void) cvSetReal3D( CvArr* arr, int idx0, int idx1, int idx2, double value );
  CVAPI(void) cvSetRealND( CvArr* arr, const int* idx, double value );
}
{$EXTERNALSYM cvSetReal1D}
(* procedure cvSetReal1D(arr: pCvArr; idx0: Integer; value: double); cdecl; *)
{$EXTERNALSYM cvSetReal2D}
(* procedure cvSetReal2D(arr: pCvArr; idx0, idx1: Integer; value: double); cdecl; *)
{$EXTERNALSYM cvSetReal3D}
(* procedure cvSetReal3D(arr: pCvArr; idx0, idx1, idx2: Integer; value: double); cdecl; *)
{$EXTERNALSYM cvSetRealND}
(* procedure cvSetRealND(arr: pCvArr; idx: pInteger; value: double); cdecl; *)

{
  /* clears element of ND dense array,
  in case of sparse arrays it deletes the specified node */
  CVAPI(void) cvClearND( CvArr* arr, const int* idx );
}
{$EXTERNALSYM cvClearND}
(* procedure cvClearND(arr: pCvArr; idx: pInteger); cdecl; *)

{ Converts pCvArr (IplImage or CvMat,...) to CvMat.
  If the last parameter is non-zero, function can
  convert multi(>2)-dimensional array to CvMat as long as
  the last array's dimension is continous. The resultant
  matrix will be have appropriate (a huge) number of rows */
  CVAPI(CvMat*) cvGetMat( const pCvArr* arr, CvMat* header,
  int* coi CV_DEFAULT(NULL),
  int allowND CV_DEFAULT(0));
}
{$EXTERNALSYM cvGetMat}
(* function cvGetMat(const arr: pCvArr; header: pCvMat; coi: pInteger = nil; allowND: Integer = 0): pCvMat; cdecl; *)

{ Converts pCvArr (IplImage or CvMat) to IplImage
  CVAPI(IplImage*) cvGetImage( const pCvArr* arr, IplImage* image_header );
}
{$EXTERNALSYM cvGetImage}
(* function cvGetImage(const arr: pCvArr; image_header: pIplImage): pIplImage; cdecl; *)

{ Changes a shape of multi-dimensional array.
  new_cn == 0 means that number of channels remains unchanged.
  new_dims == 0 means that number and sizes of dimensions remain the same
  (unless they need to be changed to set the new number of channels)
  if new_dims == 1, there is no need to specify new dimension sizes
  The resultant configuration should be achievable w/o data copying.
  If the resultant array is sparse, CvSparseMat header should be passed
  to the function else if the result is 1 or 2 dimensional,
  CvMat header should be passed to the function
  else CvMatND header should be passed */
  CVAPI(pCvArr*) cvReshapeMatND( const pCvArr* arr,
  int sizeof_header, pCvArr* header,
  int new_cn, int new_dims, int* new_sizes );
  #define cvReshapeND( arr, header, new_cn, new_dims, new_sizes )   \
  cvReshapeMatND( (arr), sizeof(*(header)), (header),         \
  (new_cn), (new_dims), (new_sizes))
}
{$EXTERNALSYM cvReshapeMatND}
(* function cvReshapeMatND(const arr: pCvArr; sizeof_header: Integer; header: pCvArr; new_cn, new_dims: Integer; new_sizes: pInteger): pCvArr; cdecl; *)
{$EXTERNALSYM cvReshapeND}
function cvReshapeND(const arr: pCvArr; sizeof_header: Integer; header: pCvArr; new_cn, new_dims: Integer; new_sizes: {$IF Defined(FPC) and Defined(MSWINDOWS)}objpas.{$ENDIF}pInteger): pCvArr;
{$IFDEF USE_INLINE} inline; {$ENDIF}
{ CVAPI(CvMat*) cvReshape( const pCvArr* arr, CvMat* header,
  int new_cn, int new_rows CV_DEFAULT(0) );
}
{$EXTERNALSYM cvReshape}
(* function cvReshape(const arr: pCvArr; header: pCvMat; new_cn: Integer; new_rows: Integer = 0): pCvMat; cdecl; *)

{ Repeats source 2d array several times in both horizontal and
  vertical direction to fill destination array
  CVAPI(void) cvRepeat( const pCvArr* src, pCvArr* dst );
}
{$EXTERNALSYM cvRepeat}
(* procedure cvRepeat(src, dst: pCvArr); cdecl; *)

{ Allocates array data
  CVAPI(void)  cvCreateData( pCvArr* arr );
}
(* procedure cvCreateData(arr: pCvArr); cdecl; *)

{ Releases array data
  CVAPI(void)  cvReleaseData( pCvArr* arr );
}
(* procedure cvReleaseData(arr: pCvArr); cdecl; *)

{ Attaches user data to the array header. The step is reffered to
  the pre-last dimension. That is, all the planes of the array
  must be joint (w/o gaps) */
  CVAPI(void)  cvSetData( pCvArr* arr, void* data, int step );
}
(* procedure cvSetData(arr: pCvArr; data: Pointer; step: Integer); cdecl; *)

{ Retrieves raw data of CvMat, IplImage or CvMatND.
  In the latter case the function raises an error if
  the array can not be represented as a matrix */
  CVAPI(void) cvGetRawData( const pCvArr* arr, uchar** data,
  int* step CV_DEFAULT(NULL),
  CvSize* roi_size CV_DEFAULT(NULL));
}
(* procedure cvGetRawData(arr: pCvArr; data: pByte; step: pInteger = nil; roi_size: pCvSize = nil); cdecl; *)

{ Returns width and height of array in elements
  CVAPI(CvSize) cvGetSize( const pCvArr* arr );
}
(* function cvGetSize(const arr: pCvArr): TCvSize; cdecl; *)

{ Copies source array to destination array */
  CVAPI(void)  cvCopy( const pCvArr* src, pCvArr* dst,
  const pCvArr* mask CV_DEFAULT(NULL) );
}

(* procedure cvCopy(const src: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; overload; *)
// (* procedure cvCopy(const src: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl; overload; *)

{ Sets all or "masked" elements of input array
  to the same value
  CVAPI(void)  cvSet( pCvArr* arr, CvScalar value,
  const pCvArr* mask CV_DEFAULT(NULL) );
}
(* procedure cvSet(arr: pCvArr; value: TCvScalar; const mask: pCvArr = nil); cdecl; overload; *)

(* procedure cvSet(mat: pCvMat; i, j: Integer; val: Single); {$IFDEF USE_INLINE} inline; {$ENDIF} overload; *)

{ Clears all the array elements (sets them to 0)
  CVAPI(void)  cvSetZero( pCvArr* arr );
  #define cvZero  cvSetZero
}
(* procedure cvSetZero(arr: pCvArr); cdecl; *)

(* procedure cvZero(arr: pCvArr); cdecl; *)

{ Splits a multi-channel array into the set of single-channel arrays or
  extracts particular [color] plane */
  CVAPI(void)  cvSplit( const pCvArr* src, pCvArr* dst0, pCvArr* dst1,
  pCvArr* dst2, pCvArr* dst3 );
}
(* procedure cvSplit(const src: pCvArr; dst0: pCvArr; dst1: pCvArr; dst2: pCvArr = nil; dst3: pCvArr = nil); cdecl; *)

{ Merges a set of single-channel arrays into the single multi-channel array
  or inserts one particular [color] plane to the array */
  CVAPI(void)  cvMerge( const pCvArr* src0, const pCvArr* src1,
  const pCvArr* src2, const pCvArr* src3,
  pCvArr* dst );
}
// procedure cvMerge(const src0: pIplImage; const src1: pIplImage; const src2: pIplImage; const src3: pIplImage; dst: pIplImage);
// cdecl; overload;
(* procedure cvMerge(const src0: pCvArr; const src1: pCvArr; const src2: pCvArr; const src3: pCvArr; dst: pCvArr); cdecl; overload; *)

{ Copies several channels from input arrays to
  certain channels of output arrays */
  CVAPI(void)  cvMixChannels( const pCvArr** src, int src_count,
  pCvArr** dst, int dst_count,
  const int* from_to, int pair_count );
}
(* procedure cvMixChannels(src: array of pCvArr; src_count: Integer; dst: array of pCvArr; dst_count: Integer; const from_to: pInteger;
  pair_count: Integer); cdecl; *)

{ Performs linear transformation on every source array element:
  dst(x,y,c) = scale*src(x,y,c)+shift.
  Arbitrary combination of input and output array depths are allowed
  (number of channels must be the same), thus the function can be used
  for type conversion
  CVAPI(void)  cvConvertScale( const pCvArr* src, pCvArr* dst,
  double scale CV_DEFAULT(1),
  double shift CV_DEFAULT(0) );
  #define cvCvtScale cvConvertScale
  #define cvConvert( src, dst )  cvConvertScale( (src), (dst), 1, 0 )
}
(* procedure cvConvertScale(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl; *)
// #define cvScale  cvConvertScale

(* procedure cvScale(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl; *)

(* procedure cvCvtScale(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl; *)

procedure cvConvert(const src: pCvArr; dst: pCvArr); {$IFDEF USE_INLINE} inline; {$ENDIF}
{ Performs linear transformation on every source array element,
  stores absolute value of the result:
  dst(x,y,c) = abs(scale*src(x,y,c)+shift).
  destination array must have 8u type.
  In other cases one may use cvConvertScale + cvAbsDiffS */
  CVAPI(void)  cvConvertScaleAbs( const pCvArr* src, pCvArr* dst,
  double scale CV_DEFAULT(1),
  double shift CV_DEFAULT(0) );
  #define cvCvtScaleAbs  cvConvertScaleAbs
}

(* procedure cvConvertScaleAbs(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl; *)

{ checks termination criteria validity and
  sets eps to default_eps (if it is not set),
  max_iter to default_max_iters (if it is not set)
  CVAPI(CvTermCriteria) cvCheckTermCriteria( CvTermCriteria criteria,
  double default_eps,
  int default_max_iters );
}
(* function cvCheckTermCriteria(criteria: TCvTermCriteria; default_eps: double; default_max_iters: Integer): TCvTermCriteria; cdecl; *)

{ ***************************************************************************************
  *                   Arithmetic, logic and comparison operations                       *
  *************************************************************************************** }

{
  dst(mask) = src1(mask) + src2(mask)
  CVAPI(void)  cvAdd( const pCvArr* src1, const pCvArr* src2, pCvArr* dst,
  const pCvArr* mask CV_DEFAULT(NULL));
}
// (* procedure cvAdd(const src1, src2: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl; overload; *)
(* procedure cvAdd(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; overload; *)

{
  dst(mask) = src(mask) + value
  CVAPI(void)  cvAddS( const pCvArr* src, CvScalar value, pCvArr* dst,
  const pCvArr* mask CV_DEFAULT(NULL));
}
// (* procedure cvAddS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil); cdecl; overload; *)
(* procedure cvAddS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; overload; *)

{
  dst(mask) = src1(mask) - src2(mask)
  CVAPI(void)  cvSub( const pCvArr* src1, const pCvArr* src2, pCvArr* dst,
  const pCvArr* mask CV_DEFAULT(NULL));
}
// (* procedure cvSub(const src1, src2: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl; overload; *)
(* procedure cvSub(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; overload; *)

// dst(mask) = src(mask) - value = src(mask) + (-value)
// CV_INLINE  void  cvSubS( const pCvArr* src, CvScalar value, pCvArr* dst,
// const pCvArr* mask CV_DEFAULT(NULL))
// {
// cvAddS( src, cvScalar( -value.val[0], -value.val[1], -value.val[2], -value.val[3]),
// dst, mask );
// }
// procedure cvSubS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil);
// {$IFDEF USE_INLINE} inline; {$ENDIF} overload;
procedure cvSubS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil);
{$IFDEF USE_INLINE} inline; {$ENDIF} overload;
{ dst(mask) = value - src(mask)
  CVAPI(void)  cvSubRS( const pCvArr* src, CvScalar value, pCvArr* dst,
  const pCvArr* mask CV_DEFAULT(NULL));
}

// (* procedure cvSubRS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil); cdecl; overload; *)
(* procedure cvSubRS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; overload; *)

{ dst(idx) = src1(idx) * src2(idx) * scale
  (scaled element-wise multiplication of 2 arrays) */
  CVAPI(void)  cvMul( const pCvArr* src1, const pCvArr* src2,
  pCvArr* dst, double scale CV_DEFAULT(1) );
}
// (* procedure cvMul(const src1, src2: pIplImage; dst: pIplImage; scale: double = 1); cdecl; overload; *)
(* procedure cvMul(const src1, src2: pCvArr; dst: pCvArr; scale: double = 1); cdecl; overload; *)

{ element-wise division/inversion with scaling:
  dst(idx) = src1(idx) * scale / src2(idx)
  or dst(idx) = scale / src2(idx) if src1 == 0 */
  CVAPI(void)  cvDiv( const pCvArr* src1, const pCvArr* src2,
  pCvArr* dst, double scale CV_DEFAULT(1));
}
// (* procedure cvDiv(const src1, src2: pIplImage; dst: pIplImage; scale: double = 1); cdecl; overload; *)
(* procedure cvDiv(const src1, src2: pCvArr; dst: pCvArr; scale: double = 1); cdecl; overload; *)

{ dst = src1 * scale + src2
  CVAPI(void)  cvScaleAdd( const pCvArr* src1, CvScalar scale,
  const pCvArr* src2, pCvArr* dst );
  #define cvAXPY( A, real_scalar, B, C ) cvScaleAdd(A, cvRealScalar(real_scalar), B, C)
}
// (* procedure cvScaleAdd(const src1: pIplImage; scale: TCvScalar; const src2: pIplImage; dst: pIplImage); cdecl; overload; *)
(* procedure cvScaleAdd(const src1: pCvArr; scale: TCvScalar; const src2: pCvArr; dst: pCvArr); cdecl; overload; *)

procedure cvAXPY(A: pIplImage; real_scalar: double; B, C: pIplImage); {$IFDEF USE_INLINE} inline; {$ENDIF} overload;
procedure cvAXPY(A: pCvArr; real_scalar: double; B, C: pCvArr); {$IFDEF USE_INLINE} inline; {$ENDIF} overload;
{ dst = src1 * alpha + src2 * beta + gamma
  CVAPI(void)  cvAddWeighted( const pCvArr* src1, double alpha,
  const pCvArr* src2, double beta,
  double gamma, pCvArr* dst );
}

// procedure cvAddWeighted(const src1: pIplImage; alpha: double; const src2: pIplImage; beta: double; gamma: double; dst: pIplImage);
// cdecl; overload;
(* procedure cvAddWeighted(const src1: pCvArr; alpha: double; const src2: pCvArr; beta: double; gamma: double; dst: pCvArr); cdecl; overload; *)

{ result = sum_i(src1(i) * src2(i)) (results for all channels are accumulated together)
  CVAPI(double)  cvDotProduct( const pCvArr* src1, const pCvArr* src2 );
}
(* function cvDotProduct(const src1, src2: pCvArr): double; cdecl; *)

{ dst(idx) = src1(idx) & src2(idx)
  CVAPI(void) cvAnd( const pCvArr* src1, const pCvArr* src2,
  pCvArr* dst, const pCvArr* mask CV_DEFAULT(NULL));
}
// (* procedure cvAnd(const src1: pIplImage; const src2: pIplImage; dst: pIplImage; masl: pIplImage = nil); cdecl; overload; *)
(* procedure cvAnd(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; masl: pCvArr = nil); cdecl; overload; *)

(* dst(idx) = src(idx) & value *)
{
  CVAPI(void) cvAndS( const CvArr* src, CvScalar value,
  CvArr* dst, const CvArr* mask CV_DEFAULT(NULL));
}

(* procedure cvAndS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; *)

//void cvOrS(const CvArr* src, CvScalar value, CvArr* dst, const CvArr* mask=NULL)
(* procedure cvOrS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; *)

//void cvCmp(const CvArr* src1, const CvArr* src2, CvArr* dst, int cmp_op)
(* procedure cvCmp(const src1, src2: pCvArr; dst: pCvArr;  cmp_op: integer); cdecl; *)

//void cvCmpS(const CvArr* src, double value, CvArr* dst, int cmp_op)¶
(* procedure cvCmpS(const src: pCvArr; value: double; dst: pCvArr;  cmp_op: integer); cdecl; *)

//void cvMin(const CvArr* src1, const CvArr* src2, CvArr* dst)
(* procedure cvMin(const src1, src2:pCvArr; dst:pCvArr); cdecl; *)

//void cvMinS(const CvArr* src, double value, CvArr* dst)¶
(* procedure cvMinS(const src:pCvArr; value:double; dst:pCvArr); cdecl; *)


//void cvMax(const CvArr* src1, const CvArr* src2, CvArr* dst)
(* procedure cvMax(const src1, src2:pCvArr; dst:pCvArr); cdecl; *)

//void cvMaxS(const CvArr* src, double value, CvArr* dst)
(* procedure cvMaxS(const src:pCvArr; value:double; dst:pCvArr); cdecl; *)

// dst(x,y,c) = abs(src1(x,y,c) - src2(x,y,c))
// CVAPI(void) cvAbsDiff( const pCvArr* src1, const pCvArr* src2, pCvArr* dst );
(* procedure cvAbsDiff(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl; *)

//void cvAbsDiffS(const CvArr* src, CvArr* dst, CvScalar value)¶
(* procedure cvAbsDiffS(const src: pCvArr; dst: pCvArr;value:TCvScalar); cdecl; *)

//CVAPI(void) cvSort( const CvArr* src, CvArr* dst CV_DEFAULT(NULL),
//                    CvArr* idxmat CV_DEFAULT(NULL),
//                    int flags CV_DEFAULT(0));
(* procedure cvSort(const src:pCvArr; dst : pCvArr = nil;
                    idxmat :pCvArr=nil;
                    flags : integer =0); cdecl; *)

function cvGet(const mat: pCvMat; i, j: Integer): Single; {$IFDEF USE_INLINE} inline; {$ENDIF}
// (* procedure cvCopyImage(const src: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl; overload; *)
// (* procedure cvCopyImage(const src: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; overload; *)

{ dst(idx) = src1(idx) | src2(idx) */
  CVAPI(void) cvOr( const CvArr* src1, const CvArr* src2,
  CvArr* dst, const CvArr* mask CV_DEFAULT(NULL));
}
(* procedure cvOr(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; *)

{ dst(idx) = src1(idx) ^ src2(idx) */
  CVAPI(void) cvXor( const CvArr* src1, const CvArr* src2,
  CvArr* dst, const CvArr* mask CV_DEFAULT(NULL));
}
(* procedure cvXor(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; *)

{ dst(idx) = src(idx) ^ value
  CVAPI(void) cvXorS( const pCvArr* src, CvScalar value, pCvArr* dst, const pCvArr* mask CV_DEFAULT(NULL));
}
// (* procedure cvXorS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pCvArr = nil); cdecl; overload; *)
(* procedure cvXorS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; overload; *)

{ dst(idx) = ~src(idx) */
  CVAPI(void) cvNot( const CvArr* src, CvArr* dst );
}
(* procedure cvNot(const src: pCvArr; dst: pCvArr); cdecl; *)

{ dst(idx) = lower(idx) <= src(idx) < upper(idx)
  CVAPI(void) cvInRange( const pCvArr* src, const pCvArr* lower, const pCvArr* upper, pCvArr* dst );
}
// (* procedure cvInRange(const src: pIplImage; const lower: pIplImage; const upper: pIplImage; dst: pIplImage); cdecl; overload; *)
(* procedure cvInRange(const src: pCvArr; const lower: pCvArr; const upper: pCvArr; dst: pCvArr); cdecl; overload; *)

{ dst(idx) = lower <= src(idx) < upper
  CVAPI(void) cvInRangeS( const pCvArr* src, CvScalar lower, CvScalar upper, pCvArr* dst );
}
// (* procedure cvInRangeS(const src: pIplImage; lower: TCvScalar; upper: TCvScalar; dst: pIplImage); cdecl; overload; *)
(* procedure cvInRangeS(const src: pCvArr; lower: TCvScalar; upper: TCvScalar; dst: pCvArr); cdecl; overload; *)

const
  CV_RAND_UNI    = 0;
  CV_RAND_NORMAL = 1;

  // CVAPI(void)cvRandArr(CvRNG * rng, CvArr * arr, int dist_type, CvScalar param1, CvScalar param2);
(* procedure cvRandArr(rng: pCvRNG; arr: pCvArr; dist_type: Integer; param1: TCvScalar; param2: TCvScalar); cdecl; *)

// CVAPI(void)cvRandShuffle(CvArr * mat, CvRNG * rng, double iter_factor CV_DEFAULT(1. ));
(* procedure cvRandShuffle(mat: pCvArr; rng: pCvRNG; iter_factor: double = 1); cdecl; *)

(*
  CVAPI(void) cvSort( const CvArr* src, CvArr* dst CV_DEFAULT(NULL),
  CvArr* idxmat CV_DEFAULT(NULL),
  int flags CV_DEFAULT(0));
*)
//procedure cvSort(const src: pCvArr; dst: pCvArr = nil; idxmat: pCvArr = nil; flags: Integer = 0); cdecl;

(*
  Finds real roots of a cubic equation
*)
(*
  CVAPI(int) cvSolveCubic( const CvMat* coeffs, CvMat* roots );
*)

(* function cvSolveCubic(const coeffs: pCvMat; roots: pCvMat): Integer; cdecl; *)
(*
  Finds all real and complex roots of a polynomial equation
*)
(*
  CVAPI(void) cvSolvePoly(const CvMat* coeffs, CvMat *roots2,
  int maxiter CV_DEFAULT(20), int fig CV_DEFAULT(100));
*)

(* procedure cvSolvePoly(const coeffs: pCvMat; roots2: pCvMat; maxiter: Integer = 20; fig: Integer = 100); cdecl; *)

{ ****************************************************************************************
  *                                Math operations                                       *
  **************************************************************************************** }

// * Does cartesian->polar coordinates conversion.
// Either of output components (magnitude or angle) is optional */
// CVAPI(void)  cvCartToPolar( const CvArr* x, const CvArr* y,
// CvArr* magnitude, CvArr* angle CV_DEFAULT(NULL),
// int angle_in_degrees CV_DEFAULT(0));
(* procedure cvCartToPolar(const x: pCvArr; const y: pCvArr; magnitude: pCvArr; angle: pCvArr = nil; angle_in_degrees: Integer = 0); cdecl; *)

// * Does polar->cartesian coordinates conversion.
// Either of output components (magnitude or angle) is optional.
// If magnitude is missing it is assumed to be all 1's */
// CVAPI(void)  cvPolarToCart( const CvArr* magnitude, const CvArr* angle,
// CvArr* x, CvArr* y,
// int angle_in_degrees CV_DEFAULT(0));
(* procedure cvPolarToCart(const magnitude: pCvArr; const angle: pCvArr; x: pCvArr; y: pCvArr; angle_in_degrees: Integer = 0); cdecl; *)

// * Does powering: dst(idx) = src(idx)^power */
// CVAPI(void)  cvPow( const CvArr* src, CvArr* dst, double power );
(* procedure cvPow(const src: pCvArr; dst: pCvArr; power: double); cdecl; *)

// * Does exponention: dst(idx) = exp(src(idx)).
// Overflow is not handled yet. Underflow is handled.
// Maximal relative error is ~7e-6 for single-precision input */
// CVAPI(void)  cvExp( const CvArr* src, CvArr* dst );
(* procedure cvExp(const src: pCvArr; dst: pCvArr); cdecl; *)

// * Calculates natural logarithms: dst(idx) = log(abs(src(idx))).
// Logarithm of 0 gives large negative number(~-700)
// Maximal relative error is ~3e-7 for single-precision output
// CVAPI(void)  cvLog( const CvArr* src, CvArr* dst );
(* procedure cvLog(const src: pCvArr; dst: pCvArr); cdecl; *)

// * Fast arctangent calculation */
// CVAPI(float) cvFastArctan( float y, float x );
(* function cvFastArctan(y, x: Float): Float; cdecl; *)

// * Fast cubic root calculation */
// CVAPI(float)  cvCbrt( float value );
(* function cvCbrt(value: Float): Float; cdecl; *)

// * Checks array values for NaNs, Infs or simply for too large numbers
// (if CV_CHECK_RANGE is set). If CV_CHECK_QUIET is set,
// no runtime errors is raised (function returns zero value in case of "bad" values).
// Otherwise cvError is called */
const
  CV_CHECK_RANGE = 1;
  CV_CHECK_QUIET = 2;

  // CVAPI(int)  cvCheckArr( const CvArr* arr, int flags CV_DEFAULT(0),
  // double min_val CV_DEFAULT(0), double max_val CV_DEFAULT(0));
(* function cvCheckArr(const arr: pCvArr; flags: Integer = 0; min_val: double = 0; max_val: double = 0): Integer; cdecl; *)
// #define cvCheckArray cvCheckArr

// (* Mirror array data around horizontal (flip=0),
// vertical (flip=1) or both(flip=-1) axises:
// cvFlip(src) flips images vertically and sequences horizontally (inplace) *)
// procedure cvFlip(v1: 0); var Performs Singular value Decomposition of A Matrix * )

(* procedure cvFlip(const src: pCvArr; dst: pCvArr = nil; flip_mode: Integer = 0); cdecl; *)
// #define cvMirror cvFlip
(* procedure cvMirror(const src: pCvArr; dst: pCvArr = nil; flip_mode: Integer = 0); cdecl; *)

const
  // * types of array norm */
  CV_C           = 1;
  CV_L1          = 2;
  CV_L2          = 4;
  CV_NORM_MASK   = 7;
  CV_RELATIVE    = 8;
  CV_DIFF        = 16;
  CV_MINMAX      = 32;
  CV_DIFF_C      = (CV_DIFF or CV_C);
  CV_DIFF_L1     = (CV_DIFF or CV_L1);
  CV_DIFF_L2     = (CV_DIFF or CV_L2);
  CV_RELATIVE_C  = (CV_RELATIVE or CV_C);
  CV_RELATIVE_L1 = (CV_RELATIVE or CV_L1);
  CV_RELATIVE_L2 = (CV_RELATIVE or CV_L2);

  // * Finds norm, difference norm or relative difference norm for an array (or two arrays) */
  // CVAPI(double)  cvNorm( const pCvArr* arr1, const pCvArr* arr2 CV_DEFAULT(NULL),
  // int norm_type CV_DEFAULT(CV_L2),
  // const pCvArr* mask CV_DEFAULT(NULL) );
(* function cvNorm(const arr1: pCvArr; const arr2: pCvArr = nil; norm_type: Integer = CV_L2; const mask: pCvArr = nil): double; cdecl; *)

(*

  CVAPI(void)  cvNormalize( const CvArr* src, CvArr* dst,
  double a CV_DEFAULT(1.), double b CV_DEFAULT(0.),
  int norm_type CV_DEFAULT(CV_L2),
  const CvArr* mask CV_DEFAULT(NULL) );

*)
(* procedure cvNormalize(const src: pCvArr; dst: pCvArr; A: double { = CV_DEFAULT(1) }; B: double { =CV_DEFAULT(0.) }; norm_type: Integer { =CV_DEFAULT(CV_L2) };
  const mask: pCvArr = nil); cdecl; *)


// ****************************************************************************************
// *                                Matrix operations
// ****************************************************************************************

// * Calculates cross product of two 3d vectors */
// CVAPI(void)  cvCrossProduct( const CvArr* src1, const CvArr* src2, CvArr* dst );
(* procedure cvCrossProduct(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl; *)

// * Matrix transform: dst = A*B + C, C is optional */
// #define cvMatMulAdd( src1, src2, src3, dst ) cvGEMM( (src1), (src2), 1., (src3), 1., (dst), 0 )
procedure cvMatMulAdd(const src1, src2, src3: pCvArr; dst: pCvArr);
// #define cvMatMul( src1, src2, dst )  cvMatMulAdd( (src1), (src2), NULL, (dst))

const
  CV_GEMM_A_T = 1;
  CV_GEMM_B_T = 2;
  CV_GEMM_C_T = 4;

  // * Extended matrix transform:
  // dst = alpha*op(A)*op(B) + beta*op(C), where op(X) is X or X^T */
  // CVAPI(void)  cvGEMM( const CvArr* src1, const CvArr* src2, double alpha,
  // const CvArr* src3, double beta, CvArr* dst,
  // int tABC CV_DEFAULT(0));
(* procedure cvGEMM(const src1: pCvArr; const src2: pCvArr; alpha: double; const src3: pCvArr; beta: double; dst: pCvArr; tABC: Integer = 0); cdecl; *)
// #define cvMatMulAddEx cvGEMM
(* procedure cvMatMulAddEx(const src1: pCvArr; const src2: pCvArr; alpha: double; const src3: pCvArr; beta: double; dst: pCvArr; tABC: Integer = 0); cdecl; *)

/// * Transforms each element of source array and stores
// resultant vectors in destination array */
// CVAPI(void)  cvTransform( const CvArr* src, CvArr* dst,
// const CvMat* transmat,
// const CvMat* shiftvec CV_DEFAULT(NULL));
(* procedure cvTransform(const src: pCvArr; dst: pCvArr; const transmat: pCvMat; const shiftvec: pCvMat = nil); cdecl; *)
// #define cvMatMulAddS cvTransform
(* procedure cvMatMulAddS(const src: pCvArr; dst: pCvArr; const transmat: pCvMat; const shiftvec: pCvMat = nil); cdecl; *)

/// * Does perspective transform on every element of input array */
// CVAPI(void)  cvPerspectiveTransform( const CvArr* src, CvArr* dst,
// const CvMat* mat );
(* procedure cvPerspectiveTransform(const src: pCvArr; dst: pCvArr; const mat: pCvMat); cdecl; *)

/// * Calculates (A-delta)*(A-delta)^T (order=0) or (A-delta)^T*(A-delta) (order=1) */
// CVAPI(void) cvMulTransposed( const CvArr* src, CvArr* dst, int order,
// const CvArr* delta CV_DEFAULT(NULL),
// double scale CV_DEFAULT(1.) );
(* procedure cvMulTransposed(const src: pCvArr; dst: pCvArr; order: Integer; const delta: pCvArr = nil; scale: double = 1); cdecl; *)

/// * Tranposes matrix. Square matrices can be transposed in-place */
// CVAPI(void)  cvTranspose( const CvArr* src, CvArr* dst );
(* procedure cvTranspose(const src: pCvArr; dst: pCvArr); cdecl; *)
// #define cvT cvTranspose
(* procedure cvT(const src: pCvArr; dst: pCvArr); cdecl; *)

/// * Completes the symmetric matrix from the lower (LtoR=0) or from the upper (LtoR!=0) part */
// CVAPI(void)  cvCompleteSymm( CvMat* matrix, int LtoR CV_DEFAULT(0) );
(* procedure cvCompleteSymm(matrix: pCvMat; LtoR: Integer = 0); cdecl; *)

const
  CV_SVD_MODIFY_A = 1;
  CV_SVD_U_T      = 2;
  CV_SVD_V_T      = 4;

  /// * Performs Singular Value Decomposition of a matrix */
  // CVAPI(void)   cvSVD( CvArr* A, CvArr* W, CvArr* U CV_DEFAULT(NULL),
  // CvArr* V CV_DEFAULT(NULL), int flags CV_DEFAULT(0));
(* procedure cvSVD(A: pCvArr; W: pCvArr; U: pCvArr = nil; V: pCvArr = nil; flags: Integer = 0); cdecl; *)

/// * Performs Singular Value Back Substitution (solves A*X = B):
// flags must be the same as in cvSVD */
// CVAPI(void)   cvSVBkSb( const CvArr* W, const CvArr* U,
// const CvArr* V, const CvArr* B,
// CvArr* X, int flags );
(* procedure cvSVBkSb(const W: pCvArr; const U: pCvArr; const V: pCvArr; const B: pCvArr; x: pCvArr; flags: Integer); cdecl; *)

const
  CV_LU       = 0;
  CV_SVD      = 1;
  CV_SVD_SYM  = 2;
  CV_CHOLESKY = 3;
  CV_QR       = 4;
  CV_NORMAL   = 16;

  // * Inverts matrix */
  // CVAPI(double)  cvInvert( const CvArr* src, CvArr* dst,
  // int method CV_DEFAULT(CV_LU));
(* function cvInvert(const src: pCvArr; dst: pCvArr; method: Integer = CV_LU): double; cdecl; *)

(*
  Solves linear system (src1)*(dst) = (src2)
  (returns 0 if src1 is a singular and CV_LU method is used)

  CVAPI(int)  cvSolve( const CvArr* src1, const CvArr* src2, CvArr* dst,
  int method CV_DEFAULT(CV_LU));
*)
(* function cvSolve(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; method: Integer = CV_LU): Integer; cdecl; *)

(*
  Calculates determinant of input matrix
  CVAPI(double) cvDet( const CvArr* mat );
*)
(* function cvDet(const mat: pCvArr): double; cdecl; *)

(*
  Calculates trace of the matrix (sum of elements on the main diagonal)
  CVAPI(CvScalar) cvTrace( const CvArr* mat );
*)
(* function cvTrace(const mat: pCvArr): TCvScalar; cdecl; *)

(*
  Finds eigen values and vectors of a symmetric matrix

  CVAPI(void)  cvEigenVV( CvArr* mat, CvArr* evects, CvArr* evals,
  double eps CV_DEFAULT(0),
  int lowindex CV_DEFAULT(-1),
  int highindex CV_DEFAULT(-1));
*)
(* procedure cvEigenVV(mat: pCvArr; evects: pCvArr; evals: pCvArr; eps: double = 0; lowindex: Integer = -1; highindex: Integer = -1); cdecl; *)
/// * Finds selected eigen values and vectors of a symmetric matrix */
// CVAPI(void)  cvSelectedEigenVV( CvArr* mat, CvArr* evects, CvArr* evals,
// int lowindex, int highindex );
(*
  Makes an identity matrix (mat_ij = i == j)

  CVAPI(void)  cvSetIdentity( CvArr* mat, CvScalar value CV_DEFAULT(cvRealScalar(1)) );
*)

(* procedure cvSetIdentity(mat: pCvArr; value: TCvScalar { =cvRealScalar(1) } ); cdecl; *)
(*
  Fills matrix with given range of numbers

  CVAPI(CvArr* )  cvRange( CvArr* mat, double start, double end );
*)

(* function cvRange(mat: pCvArr; start: double; end_: double): pCvArr; cdecl; *)

(*
  Calculates covariation matrix for a set of vectors

  transpose([v1-avg, v2-avg,...]) * [v1-avg,v2-avg,...]
*)

const
  CV_COVAR_SCRAMBLED = 0;
  CV_COVAR_NORMAL    = 1; // [v1-avg, v2-avg,...] * transpose([v1-avg,v2-avg,...])
  CV_COVAR_USE_AVG   = 2; // do not calc average (i.e. mean vector) - use the input vector instead
  /// //////////////////// (useful for calculating covariance matrix by parts)
  CV_COVAR_SCALE = 4; // scale the covariance matrix coefficients by number of the vectors
  CV_COVAR_ROWS  = 8; // all the input vectors are stored in a single matrix, as its rows
  CV_COVAR_COLS  = 16; // all the input vectors are stored in a single matrix, as its columns

  (*
    CVAPI(void)  cvCalcCovarMatrix( const CvArr** vects, int count,
    CvArr* cov_mat, CvArr* avg, int flags );
  *)
(* procedure cvCalcCovarMatrix(const vects: pCvArrArray; count: Integer; cov_mat: pCvArr; avg: pCvArr; flags: Integer); cdecl; *)

const
  CV_PCA_DATA_AS_ROW = 0; // #define CV_PCA_DATA_AS_ROW 0
  CV_PCA_DATA_AS_COL = 1; // #define CV_PCA_DATA_AS_COL 1
  CV_PCA_USE_AVG     = 2; // #define CV_PCA_USE_AVG 2
  (*
    CVAPI(void)  cvCalcPCA( const CvArr* data, CvArr* mean,
    CvArr* eigenvals, CvArr* eigenvects, int flags );
  *)

(* procedure cvCalcPCA(const data: pCvArr; mean: pCvArr; eigenvals: pCvArr; eigenvects: pCvArr; flags: Integer); cdecl; *)
(*
  CVAPI(void)  cvProjectPCA( const CvArr* data, const CvArr* mean,
  const CvArr* eigenvects, CvArr* result );
*)

(* procedure cvProjectPCA(const data: pCvArr; const mean: pCvArr; const eigenvects: pCvArr; result: pCvArr); cdecl; *)
(*
  CVAPI(void)  cvBackProjectPCA( const CvArr* proj, const CvArr* mean,
  const CvArr* eigenvects, CvArr* result );
*)

(* procedure cvBackProjectPCA(const proj: pCvArr; const mean: pCvArr; const eigenvects: pCvArr; result: pCvArr); cdecl; *)
(*
  Calculates Mahalanobis(weighted) distance
*)
(*
  CVAPI(double)  cvMahalanobis( const CvArr* vec1, const CvArr* vec2, const CvArr* mat );
*)

(* function cvMahalanobis(const vec1: pCvArr; const vec2: pCvArr; const mat: pCvArr): double; cdecl; *)

(*
  Calculates mean value of array elements

  CVAPI(CvScalar)  cvAvg( const CvArr* arr, const CvArr* mask CV_DEFAULT(NULL) );
*)
(* function cvAvg(const arr: pCvArr; const mask: pCvArr = nil): TCvScalar; cdecl; *)

// (* ***************************************************************************************\
// *                                    cArray Statistics                                    *
// *************************************************************************************** *)

// * Finds sum of array elements */
// CVAPI(CvScalar)  cvSum( const CvArr* arr );
(* function cvSum(const arr: pCvArr): TCvScalar; cdecl; *)

{ Calculates number of non-zero pixels
  CVAPI(Integer)cvCountNonZero(pCvArr * arr);
}
// (* function cvCountNonZero(arr: pIplImage): Integer; cdecl; overload; *)
(* function cvCountNonZero(arr: pCvArr): Integer; cdecl; overload; *)

// * Calculates mean and standard deviation of pixel values */
(* procedure cvAvgSdv(const arr: pCvArr; mean: pCvScalar; std_dev: pCvScalar; const mask: pCvArr = nil); cdecl; *)

{ Finds global minimum, maximum and their positions
  CVAPI(void)  cvMinMaxLoc(const pCvArr* arr, double* min_val, double* max_val, CvPoint* min_loc CV_DEFAULT(NULL), CvPoint* max_loc CV_DEFAULT(NULL), const pCvArr* mask CV_DEFAULT(NULL) );
}
// (* procedure cvMinMaxLoc(const arr: pIplImage; min_val: pDouble; max_val: pDouble; min_loc: pCVPoint = nil; max_loc: pCVPoint = nil;
// const mask: pIplImage = nil); cdecl; overload; *)
(* procedure cvMinMaxLoc(const arr: pCvArr; min_val: pDouble; max_val: pDouble; min_loc: pCVPoint = nil; max_loc: pCVPoint = nil; const mask: pCvArr = nil);
  cdecl; overload; *)

const
  CV_REDUCE_SUM = 0;
  CV_REDUCE_AVG = 1;
  CV_REDUCE_MAX = 2;
  CV_REDUCE_MIN = 3;

  // CVAPI(void)  cvReduce( const CvArr* src, CvArr* dst, int dim CV_DEFAULT(-1),
  // int op CV_DEFAULT(CV_REDUCE_SUM) );

(* procedure cvReduce(const src: pCvArr; dst: pCvArr; dim: Integer = -1; op: Integer = CV_REDUCE_SUM); cdecl; *)

// ****************************************************************************************
// *                      Discrete Linear Transforms and Related Functions
// ****************************************************************************************

const
  CV_DXT_FORWARD       = 0;
  CV_DXT_INVERSE       = 1;
  CV_DXT_SCALE         = 2; // * divide result by size of array */
  CV_DXT_INV_SCALE     = (CV_DXT_INVERSE + CV_DXT_SCALE);
  CV_DXT_INVERSE_SCALE = CV_DXT_INV_SCALE;
  CV_DXT_ROWS          = 4; // * transform each row individually */
  CV_DXT_MUL_CONJ      = 8; // * conjugate the second argument of cvMulSpectrums */

  // * Discrete Fourier Transform:
  // complex->complex,
  // real->ccs (forward),
  // ccs->real (inverse) */
  // CVAPI(void)  cvDFT( const CvArr* src, CvArr* dst, int flags, int nonzero_rows CV_DEFAULT(0) );

(* procedure cvDFT(const src: pCvArr; dst: pCvArr; flags: Integer; nonzero_rows: Integer = 0); cdecl; *)
(* procedure cvFFT(const src: pCvArr; dst: pCvArr; flags: Integer; nonzero_rows: Integer = 0); cdecl; *)

// #define cvFFT cvDFT

// * Multiply results of DFTs: DFT(X) * DFT(Y) or DFT(X) * conj(DFT(Y)) */
// CVAPI(void) cvMulSpectrums(const CvArr * src1, const CvArr * src2, CvArr * dst, int flags);
(* procedure cvMulSpectrums(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; flags: Integer); cdecl; *)

// * Finds optimal DFT vector size >= size0 */
// CVAPI(int)cvGetOptimalDFTSize(int size0);
(* function cvGetOptimalDFTSize(size0: Integer): Integer; cdecl; *)

/// * Discrete Cosine Transform */
// CVAPI(void)cvDCT(const CvArr * src, CvArr * dst, int flags);
(* procedure cvDCT(const src: pCvArr; dst: pCvArr; flags: Integer); cdecl; *)

// ****************************************************************************************
// *                              Dynamic data structures                                 *
// ****************************************************************************************

(*
  Calculates length of sequence slice (with support of negative indices).

  CVAPI(int) cvSliceLength( CvSlice slice, const CvSeq* seq );
*)
(* function cvSliceLength(slice: TCvSlice; const seq: pCvSeq): Integer; cdecl; *)

//* Remember a storage "free memory" position */
//CVAPI(void)  cvSaveMemStoragePos( const CvMemStorage* storage, CvMemStoragePos* pos );
(* procedure cvSaveMemStoragePos(const storage:pCvMemStorage; pos:pCvMemStoragePos); cdecl; *)

//* Restore a storage "free memory" position */
//CVAPI(void)  cvRestoreMemStoragePos( CvMemStorage* storage, CvMemStoragePos* pos );
(* procedure cvRestoreMemStoragePos(storage:pCvMemStorage; pos:pCvMemStoragePos); cdecl; *)

{ Creates new memory storage.
  block_size == 0 means that default,
  somewhat optimal size, is used (currently, it is 64K)
  CVAPI(CvMemStorage*)  cvCreateMemStorage( int block_size CV_DEFAULT(0));
}
(* function cvCreateMemStorage(block_size: Integer = 0): pCvMemStorage; cdecl; *)

{ Creates a memory storage that will borrow memory blocks from parent storage
  CVAPI(CvMemStorage*)  cvCreateChildMemStorage( CvMemStorage* parent );
}
(* function cvCreateChildMemStorage(parent: pCvMemStorage): pCvMemStorage; cdecl; *)

{ Releases memory storage. All the children of a parent must be released before
  the parent. A child storage returns all the blocks to parent when it is released
  CVAPI(void)  cvReleaseMemStorage( CvMemStorage** storage );
}
(* procedure cvReleaseMemStorage(var storage: pCvMemStorage); cdecl; *)

{ Clears memory storage. This is the only way(!!!) (besides cvRestoreMemStoragePos)
  to reuse memory allocated for the storage - cvClearSeq,cvClearSet ...
  do not free any memory.
  A child storage returns all the blocks to the parent when it is cleared
  CVAPI(void)  cvClearMemStorage( CvMemStorage* storage );
}
(* procedure cvClearMemStorage(storage: pCvMemStorage); cdecl; *)

(*
  Allocates continuous buffer of the specified size in the storage

  CVAPI(void* ) cvMemStorageAlloc( CvMemStorage* storage, size_t size );
*)
(* function cvMemStorageAlloc(storage: pCvMemStorage; size: size_t): Pointer; cdecl; *)
(*
  Allocates string in memory storage

  CVAPI(CvString) cvMemStorageAllocString( CvMemStorage* storage, const char* ptr,
  int len CV_DEFAULT(-1) );
*)

(* function cvMemStorageAllocString(storage: pCvMemStorage; const ptr: pCvChar; len: Integer = -1): TCvString; cdecl; *)

//* Changes default size (granularity) of sequence blocks.
//   The default size is ~1Kbyte */
//CVAPI(void)  cvSetSeqBlockSize( CvSeq* seq, int delta_elems );
(* procedure cvSetSeqBlockSize( seq:pCvSeq; delta_elems:Integer ); cdecl; *)

{ Creates new empty sequence that will reside in the specified storage
  CVAPI(CvSeq*)  cvCreateSeq( int seq_flags, size_t header_size,
  size_t elem_size, CvMemStorage* storage );
}
(* function cvCreateSeq(seq_flags: Integer; header_size: NativeUInt; elem_size: NativeUInt; storage: pCvMemStorage): pCvSeq; cdecl; *)

// Removes specified sequence element
// CVAPI(void)  cvSeqRemove( CvSeq* seq, int index );
(* procedure cvSeqRemove(seq: pCvSeq; index: Integer); cdecl; *)

// or cvRestoreMemStoragePos is called
// CVAPI(void)  cvClearSeq( CvSeq* seq );
(* procedure cvClearSeq(seq: pCvSeq); cdecl; *)

{ Adds new element to the end of sequence. Returns pointer to the element
  CVAPI(schar*)  cvSeqPush( CvSeq* seq, const void* element CV_DEFAULT(NULL));
}
(* function cvSeqPush(seq: pCvSeq; const element: Pointer = nil): Pointer; cdecl; *)

(*
  Adds new element to the beginning of sequence. Returns pointer to it

  CVAPI(schar* )  cvSeqPushFront( CvSeq* seq, const void* element CV_DEFAULT(NULL));
*)
(* function cvSeqPushFront(seq: pCvSeq; const element: Pointer = nil): pschar; cdecl; *)

//* Removes the last element from sequence and optionally saves it */
//CVAPI(void)  cvSeqPop( CvSeq* seq, void* element CV_DEFAULT(NULL));
(* procedure cvSeqPop(seq:pCvSeq; element : pointer = nil);cdecl; *)

//* Removes the first element from sequence and optioanally saves it */
//CVAPI(void)  cvSeqPopFront( CvSeq* seq, void* element CV_DEFAULT(NULL));
(* procedure cvSeqPopFront(seq:pCvSeq; element :pointer = nil); cdecl; *)

const
     CV_FRONT = 1;
     CV_BACK = 0;
//* Adds several new elements to the end of sequence */
//CVAPI(void)  cvSeqPushMulti( CvSeq* seq, const void* elements,
//                             int count, int in_front CV_DEFAULT(0) );
(* procedure cvSeqPushMulti(seq:pCvSeq; const elements:pointer; count:Integer; in_front:integer = 0); cdecl; *)

//* Removes several elements from the end of sequence and optionally saves them */
//CVAPI(void)  cvSeqPopMulti( CvSeq* seq, void* elements,
//                            int count, int in_front CV_DEFAULT(0) );
(* procedure cvSeqPopMulti(seq:pCvSeq; elements:pointer; count:integer; in_front:integer=0); cdecl; *)

(*
  Inserts a new element in the middle of sequence.
  cvSeqInsert(seq,0,elem) == cvSeqPushFront(seq,elem)

  CVAPI(schar* )  cvSeqInsert( CvSeq* seq, int before_index,
  const void* element CV_DEFAULT(NULL));
*)
(* function cvSeqInsert(seq: pCvSeq; before_index: Integer; const element: Pointer = nil): pschar; cdecl; *)

{ Retrieves pointer to specified sequence element.
  Negative indices are supported and mean counting from the end
  (e.g -1 means the last sequence element)
  CVAPI(schar*)  cvGetSeqElem( const CvSeq* seq, int index );
}
(* function cvGetSeqElem(const seq: pCvSeq; index: Integer): Pointer; cdecl; *)

(*
  Calculates index of the specified sequence element.
  Returns -1 if element does not belong to the sequence

  CVAPI(int)  cvSeqElemIdx( const CvSeq* seq, const void* element,
  CvSeqBlock** block CV_DEFAULT(NULL) );
*)
(* function cvSeqElemIdx(const seq: pCvSeq; const element: Pointer; block: pCvSeqBlockArray = nil): Integer; cdecl; *)

//* Initializes sequence writer. The new elements will be added to the end of sequence */
//CVAPI(void)  cvStartAppendToSeq( CvSeq* seq, CvSeqWriter* writer );
(* procedure cvStartAppendToSeq(seq:pCvSeq; writer:pCvSeqWriter); cdecl; *)

//* Combination of cvCreateSeq and cvStartAppendToSeq */
//CVAPI(void)  cvStartWriteSeq( int seq_flags, int header_size,
//                              int elem_size, CvMemStorage* storage,
//                              CvSeqWriter* writer );
(* procedure cvStartWriteSeq( seq_flags:integer; header_size:Integer;
                              elem_size:Integer; storage:pCvMemStorage;
                              writer:pCvSeqWriter); cdecl; *)

(*
  Closes sequence writer, updates sequence header and returns pointer
  to the resultant sequence
  (which may be useful if the sequence was created using cvStartWriteSeq))

  CVAPI(CvSeq*  cvEndWriteSeq( CvSeqWriter* writer );
*)
(* function cvEndWriteSeq(writer: pCvSeqWriter): pCvSeq; cdecl; *)

//* Updates sequence header. May be useful to get access to some of previously
//   written elements via cvGetSeqElem or sequence reader */
//CVAPI(void)   cvFlushSeqWriter( CvSeqWriter* writer );
(* procedure cvFlushSeqWriter( writer:pCvSeqWriter ); cdecl; *)

{ Initializes sequence reader.
  The sequence can be read in forward or backward direction
  CVAPI(void) cvStartReadSeq( const CvSeq* seq, CvSeqReader* reader, int reverse CV_DEFAULT(0) );
}
(* procedure cvStartReadSeq(const seq: Pointer; reader: pCvSeqReader; reverse: Integer = 0); cdecl; *)

(*
  Returns current sequence reader position (currently observed sequence element)

  CVAPI(int)  cvGetSeqReaderPos( CvSeqReader* reader );
*)
(* function cvGetSeqReaderPos(reader: pCvSeqReader): Integer; cdecl; *)

//* Changes sequence reader position. It may seek to an absolute or
//   to relative to the current position */
//CVAPI(void)   cvSetSeqReaderPos( CvSeqReader* reader, int index, int is_relative CV_DEFAULT(0));
(* procedure cvSetSeqReaderPos(reader:pCvSeqReader; index:Integer; is_relative :Integer = 0); cdecl; *)

{ Copies sequence content to a continuous piece of memory
  CVAPI(void*)  cvCvtSeqToArray( const CvSeq* seq, void* elements, CvSlice slice CV_DEFAULT(CV_WHOLE_SEQ)); }
(* procedure cvCvtSeqToArray(const seq: pCvSeq; elements: pCvArr; slice: TCvSlice { =CV_WHOLE_SEQ } ); cdecl; *)

(*
  Creates sequence header for array.
  After that all the operations on sequences that do not alter the content
  can be applied to the resultant sequence

  CVAPI(CvSeq* ) cvMakeSeqHeaderForArray( int seq_type, int header_size,
  int elem_size, void* elements, int total,
  CvSeq* seq, CvSeqBlock* block );
*)
(* function cvMakeSeqHeaderForArray(seq_type: Integer; header_size: Integer; elem_size: Integer; elements: Pointer; total: Integer; seq: pCvSeq;
  block: pCvSeqBlock): pCvSeq; cdecl; *)

(*
  Extracts sequence slice (with or without copying sequence elements)

  CVAPI(CvSeq* ) cvSeqSlice( const CvSeq* seq, CvSlice slice,
  CvMemStorage* storage CV_DEFAULT(NULL),
  int copy_data CV_DEFAULT(0));
*)
(* function cvSeqSlice(const seq: pCvSeq; slice: TCvSlice; storage: pCvMemStorage = nil; copy_data: Integer = 0): pCvSeq; cdecl; *)

//* Removes sequence slice */
//CVAPI(void)  cvSeqRemoveSlice( CvSeq* seq, CvSlice slice );
(* procedure cvSeqRemoveSlice( seq:pCvSeq; slice :TCvSlice); cdecl; *)

//* Inserts a sequence or array into another sequence */
//CVAPI(void)  cvSeqInsertSlice( CvSeq* seq, int before_index, const CvArr* from_arr );
(* procedure cvSeqInsertSlice(seq:pCvSeq; before_index:integer; const from_arr:pCvArr);cdecl; *)

//* a < b ? -1 : a > b ? 1 : 0 */
//typedef int (CV_CDECL* CvCmpFunc)(const void* a, const void* b, void* userdata );
type
  TCvCmpFunc = function(const a:pointer; const b:pointer; userdata: pointer):integer;cdecl;

//* Sorts sequence in-place given element comparison function */
//CVAPI(void) cvSeqSort( CvSeq* seq, CvCmpFunc func, void* userdata CV_DEFAULT(NULL) );
(* procedure cvSeqSort(seq:pCvSeq; func:TCvCmpFunc; userdata:pointer = nil); cdecl; *)

// ************ Internal sequence functions ************/

// CVAPI(void)  cvChangeSeqBlock( void* reader, int direction );
(* procedure cvChangeSeqBlock(reader: pCvSeqReader; direction: Integer); cdecl; *)
// CVAPI(void)  cvCreateSeqBlock( CvSeqWriter* writer );

(* procedure cvCreateSeqBlock(writer: pCvSeqWriter); cdecl; *)

(*
  Creates a new set

  CVAPI(CvSet* )  cvCreateSet( int set_flags, int header_size,
  int elem_size, CvMemStorage* storage );
*)
(* function cvCreateSet(set_flags: Integer; header_size: Integer; elem_size: Integer; storage: pCvMemStorage): pCvSet; cdecl; *)

(*
  Creates new graph

  CVAPI(CvGraph* )  cvCreateGraph( int graph_flags, int header_size,
  int vtx_size, int edge_size,
  CvMemStorage* storage );
*)
(* function cvCreateGraph(graph_flags: Integer; header_size: Integer; vtx_size: Integer; edge_size: Integer; storage: pCvMemStorage): pCvGraph; cdecl; *)

(*
  Adds new vertex to the graph

  CVAPI(int)  cvGraphAddVtx( CvGraph* graph, const CvGraphVtx* vtx CV_DEFAULT(NULL),
  CvGraphVtx** inserted_vtx CV_DEFAULT(NULL) );
*)
(* function cvGraphAddVtx(graph: pCvGraph; const vtx: pCvGraphVtx = nil; inserted_vtx: pCvGraphVtxArray = nil): Integer; cdecl; *)

(*
  Removes vertex from the graph together with all incident edges

  CVAPI(int)  cvGraphRemoveVtx( CvGraph* graph, int index );
*)
(* function cvGraphRemoveVtx(graph: pCvGraph; index: Integer): Integer; cdecl; *)
(*
  CVAPI(int)  cvGraphRemoveVtxByPtr( CvGraph* graph, CvGraphVtx* vtx );
*)

(* function cvGraphRemoveVtxByPtr(graph: pCvGraph; vtx: pCvGraphVtx): Integer; cdecl; *)

(*
  Link two vertices specifed by indices or pointers if they
  are not connected or return pointer to already existing edge
  connecting the vertices.
  Functions return 1 if a new edge was created, 0 otherwise
*)
(*
  CVAPI(int)  cvGraphAddEdge( CvGraph* graph,
  int start_idx, int end_idx,
  const CvGraphEdge* edge CV_DEFAULT(NULL),
  CvGraphEdge** inserted_edge CV_DEFAULT(NULL) );
*)
(* function cvGraphAddEdge(graph: pCvGraph; start_idx: Integer; end_idx: Integer; const edge: pCvGraphEdge = nil; inserted_edge: pCvGraphEdgeArray = nil)
  : Integer; cdecl; *)
(*
  CVAPI(int)  cvGraphAddEdgeByPtr( CvGraph* graph,
  CvGraphVtx* start_vtx, CvGraphVtx* end_vtx,
  const CvGraphEdge* edge CV_DEFAULT(NULL),
  CvGraphEdge** inserted_edge CV_DEFAULT(NULL) );
*)

(* function cvGraphAddEdgeByPtr(graph: pCvGraph; start_vtx: pCvGraphVtx; end_vtx: pCvGraphVtx; const edge: pCvGraphEdge = nil;
  inserted_edge: pCvGraphEdgeArray = nil): Integer; cdecl; *)
(*
  Remove edge connecting two vertices

  CVAPI(void)  cvGraphRemoveEdge( CvGraph* graph, int start_idx, int end_idx );
*)

(* procedure cvGraphRemoveEdge(graph: pCvGraph; start_idx: Integer; end_idx: Integer); cdecl; *)
(*
  CVAPI(void)  cvGraphRemoveEdgeByPtr( CvGraph* graph, CvGraphVtx* start_vtx,
  CvGraphVtx* end_vtx );
*)

(* procedure cvGraphRemoveEdgeByPtr(graph: pCvGraph; start_vtx: pCvGraphVtx; end_vtx: pCvGraphVtx); cdecl; *)
(*
  Find edge connecting two vertices

  CVAPI(CvGraphEdge* )  cvFindGraphEdge( const CvGraph* graph, int start_idx, int end_idx );
*)

(* function cvFindGraphEdge(const graph: pCvGraph; start_idx: Integer; end_idx: Integer): pCvGraphEdge; cdecl; *)
(*
  CVAPI(CvGraphEdge* )  cvFindGraphEdgeByPtr( const CvGraph* graph,
  const CvGraphVtx* start_vtx,
  const CvGraphVtx* end_vtx );
*)

(* function cvFindGraphEdgeByPtr(const graph: pCvGraph; const start_vtx: pCvGraphVtx; const end_vtx: pCvGraphVtx): pCvGraphEdge; cdecl; *)
// #define cvGraphFindEdge cvFindGraphEdge
// #define cvGraphFindEdgeByPtr cvFindGraphEdgeByPtr
(*
  Remove all vertices and edges from the graph

  CVAPI(void)  cvClearGraph( CvGraph* graph );
*)

(* procedure cvClearGraph(graph: pCvGraph); cdecl; *)
(*
  Count number of edges incident to the vertex

  CVAPI(int)  cvGraphVtxDegree( const CvGraph* graph, int vtx_idx );
*)

(* function cvGraphVtxDegree(const graph: pCvGraph; vtx_idx: Integer): Integer; cdecl; *)
(*
  CVAPI(int)  cvGraphVtxDegreeByPtr( const CvGraph* graph, const CvGraphVtx* vtx );
*)

(* function cvGraphVtxDegreeByPtr(const graph: pCvGraph; const vtx: pCvGraphVtx): Integer; cdecl; *)

(*
  Retrieves graph vertex by given index

  #define cvGetGraphVtx( graph, idx ) (CvGraphVtx* )cvGetSetElem((CvSet* )(graph), (idx))
*)

(*
  Retrieves index of a graph vertex given its pointer
  #define cvGraphVtxIdx( graph, vtx ) ((vtx)->flags & CV_SET_ELEM_IDX_MASK)
*)

(*
  Retrieves index of a graph edge given its pointer

  #define cvGraphEdgeIdx( graph, edge ) ((edge)->flags & CV_SET_ELEM_IDX_MASK)
  #define cvGraphGetVtxCount( graph ) ((graph)->active_count)
  #define cvGraphGetEdgeCount( graph ) ((graph)->edges->active_count)
*)

const
  CV_GRAPH_VERTEX       = 1;
  CV_GRAPH_TREE_EDGE    = 2;
  CV_GRAPH_BACK_EDGE    = 4;
  CV_GRAPH_FORWARD_EDGE = 8;
  CV_GRAPH_CROSS_EDGE   = 16;
  CV_GRAPH_ANY_EDGE     = 30;
  CV_GRAPH_NEW_TREE     = 32;
  CV_GRAPH_BACKTRACKING = 64;
  CV_GRAPH_OVER         = -1;
  CV_GRAPH_ALL_ITEMS    = -1;
  (*
    flags for graph vertices and edges
  *)
  CV_GRAPH_ITEM_VISITED_FLAG = (1 shl 30);

  // #define  CV_IS_GRAPH_VERTEX_VISITED(vtx) \
  // (((CvGraphVtx*)(vtx))->flags & CV_GRAPH_ITEM_VISITED_FLAG)
  // #define  CV_IS_GRAPH_EDGE_VISITED(edge) \
  // (((CvGraphEdge*)(edge))->flags & CV_GRAPH_ITEM_VISITED_FLAG)

  CV_GRAPH_SEARCH_TREE_NODE_FLAG = (1 shl 29);
  CV_GRAPH_FORWARD_EDGE_FLAG     = (1 shl 28);

type
  (* typedef  struct CvGraphScanner
    {
    CvGraphVtx* vtx;       /* current graph vertex (or current edge origin) */
    CvGraphVtx* dst;       /* current graph edge destination vertex */
    CvGraphEdge* edge;     /* current edge */

    CvGraph* graph;        /* the graph */
    CvSeq*   stack;        /* the graph vertex stack */
    int      index;        /* the lower bound of certainly visited vertices */
    int      mask;         /* event mask */
    } CvGraphScanner; *)

  pCvGraphScanner = ^TCvGraphScanner;

  TCvGraphScanner = record
    vtx: pCvGraphVtx; (* current graph vertex (or current edge origin) *)
    dst: pCvGraphVtx; (* current graph edge destination vertex *)
    edge: pCvGraphEdge; (* current edge *)
    graph: pCvGraph; (* the graph *)
    stack: pCvSeq; (* the graph vertex stack *)
    index: Integer; (* the lower bound of certainly visited vertices *)
    mask: Integer; (* event mask *)
  end;

  (*
    Creates new graph scanner.

    CVAPI(CvGraphScanner * ) cvCreateGraphScanner(CvGraph * graph, CvGraphVtx * vtx CV_DEFAULT(NULL), int mask CV_DEFAULT(CV_GRAPH_ALL_ITEMS));
  *)

(* function cvCreateGraphScanner(graph: pCvGraph; vtx: pCvGraphVtx = nil; mask: Integer = CV_GRAPH_ALL_ITEMS): pCvGraphScanner; cdecl; *)
(*
  Releases graph scanner.

  CVAPI(void) cvReleaseGraphScanner( CvGraphScanner** scanner );
*)

(* procedure cvReleaseGraphScanner(var scanner: pCvGraphScanner); cdecl; *)

(*
  Get next graph element

  CVAPI(int)  cvNextGraphItem( CvGraphScanner* scanner );
*)
(* function cvNextGraphItem(scanner: pCvGraphScanner): Integer; cdecl; *)
(*
  Creates a copy of graph

  CVAPI(CvGraph* ) cvCloneGraph( const CvGraph* graph, CvMemStorage* storage );
*)

(* function cvCloneGraph(const graph: pCvGraph; storage: pCvMemStorage): pCvGraph; cdecl; *)

//* Draws a rectangle specified by a CvRect structure */
//CVAPI(void)  cvRectangleR( CvArr* img, CvRect r,
//                           CvScalar color, int thickness CV_DEFAULT(1),
//                           int line_type CV_DEFAULT(8),
//                           int shift CV_DEFAULT(0));
(* procedure cvRectangleR( img:pCvArr; r:TCvRect; color:TCvScalar; thickness:integer=1;
                                                      line_type :integer =8;
                                                      shift:integer=0); cdecl; *)

//* Fills an area bounded by one or more arbitrary polygons */
//CVAPI(void)  cvFillPoly( CvArr* img, CvPoint** pts, const int* npts,
//                         int contours, CvScalar color,
//                         int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0) );
(* procedure cvFillPoly( img:pCvArr; pts:pCvPointArray; const npts:pInteger;
                                                  contours:Integer; color:TCvScalar;
                                                  line_type :Integer=8; shift :Integer=0 ); cdecl; *)

(* Does look-up transformation. Elements of the source array
  (that should be 8uC1 or 8sC1) are used as indexes in lutarr 256-element table

  CVAPI(void) cvLUT( const CvArr* src, CvArr* dst, const CvArr* lut );

*)
(* procedure cvLUT(const src: pCvArr; dst: pCvArr; const lut: pCvArr); cdecl; *)

(*
  Adds new element to the set and returns pointer to it

  CVAPI(int)  cvSetAdd( CvSet* set_header, CvSetElem* elem CV_DEFAULT(NULL),
  CvSetElem** inserted_elem CV_DEFAULT(NULL) );
*)
(* function cvSetAdd(set_header: pCvSet; elem: pCvSetElem = nil; inserted_elem: pCvSetElemArray = nil): Integer; cdecl; *)

//* Removes element from the set by its index  */
//CVAPI(void)   cvSetRemove( CvSet* set_header, int index );
(* procedure cvSetRemove(set_header:pCvSet; index:Integer );cdecl; *)

//* Removes all the elements from the set */
//CVAPI(void)  cvClearSet( CvSet* set_header );
(* procedure cvClearSet( set_header:pCvSet ); cdecl; *)

// * writes an integer */
// CVAPI(void) cvWriteInt( CvFileStorage* fs, const char* name, int value );
(* procedure cvWriteInt(fs: pCvFileStorage; const name: pCvChar; value: Integer); cdecl; *)

// * writes a floating-point number */
// CVAPI(void) cvWriteReal( CvFileStorage* fs, const char* name, double value );
(* procedure cvWriteReal(fs: pCvFileStorage; const name: pCvChar; value: double); cdecl; *)

// * writes a string */
// CVAPI(void) cvWriteString( CvFileStorage* fs, const char* name,const char* str, int quote CV_DEFAULT(0) );
(* procedure cvWriteString(fs: pCvFileStorage; const name: pCvChar; const str: pCvChar; quote: Integer = 0); cdecl; *)

// * writes a comment */
// CVAPI(void) cvWriteComment( CvFileStorage* fs, const char* comment,int eol_comment );
(* procedure cvWriteComment(fs: pCvFileStorage; const comment: pCvChar; eol_comment: Integer); cdecl; *)

// writes instance of a standard type (matrix, image, sequence, graph etc.)
// or user-defined type */
// CVAPI(void) cvWrite( CvFileStorage* fs, const char* name, const void* ptr,
// CvAttrList attributes CV_DEFAULT(cvAttrList()));
(* procedure cvWrite(fs: pCvFileStorage; const name: pCvChar; const ptr: pCvArr; attributes: TCvAttrList { = cvAttrList() } ); cdecl; *)

(*
  starts the next stream

  CVAPI(void) cvStartNextStream( CvFileStorage* fs );
*)
(* procedure cvStartNextStream(fs: pCvFileStorage); cdecl; *)
(*
  helper function: writes multiple integer or floating-point numbers

  CVAPI(void) cvWriteRawData( CvFileStorage* fs, const void* src,
  int len, const char* dt );
*)

(* procedure cvWriteRawData(fs: pCvFileStorage; const src: Pointer; len: Integer; const dt: pCvChar); cdecl; *)
(*
  returns the hash entry corresponding to the specified literal key string or 0
  if there is no such a key in the storage

  CVAPI(CvStringHashNode* ) cvGetHashedKey( CvFileStorage* fs, const char* name,
  int len CV_DEFAULT(-1),
  int create_missing CV_DEFAULT(0));
*)

(* function cvGetHashedKey(fs: pCvFileStorage; const name: pCvChar; len: Integer = -1; create_missing: Integer = 0): pCvStringHashNode; cdecl; *)
(*
  returns file node with the specified key within the specified map
  (collection of named nodes)

  CVAPI(CvFileNode* ) cvGetRootFileNode( const CvFileStorage* fs,
  int stream_index CV_DEFAULT(0) );
*)

(* function cvGetRootFileNode(const fs: pCvFileStorage; stream_index: Integer = 0): pCvFileNode; cdecl; *)
(*
  returns file node with the specified key within the specified map
  (collection of named nodes)

  CVAPI(CvFileNode* cvGetFileNode( CvFileStorage* fs, CvFileNode* map,
  const CvStringHashNode* key,
  int create_missing CV_DEFAULT(0) );
*)

(* function cvGetFileNode(fs: pCvFileStorage; map: pCvFileNode; const key: pCvStringHashNode; create_missing: Integer = 0): pCvFileNode; cdecl; *)

(* function cvSeqPartition(const seq: pCvSeq; storage: pCvMemStorage; labels: pCvSeq; is_equal: TCvCmpFunc; userdata: Pointer): Integer; cdecl; *)

(*
  Finds element in a [sorted] sequence

  CVAPI(schar* ) cvSeqSearch( CvSeq* seq, const void* elem, CvCmpFunc func,
  int is_sorted, int* elem_idx,
  void* userdata CV_DEFAULT(NULL) );
*)
(* function cvSeqSearch(seq: pCvSeq; const elem: Pointer; func: TCvCmpFunc; is_sorted: Integer; elem_idx: pInteger; userdata: Pointer = nil): pschar; cdecl; *)

//* Reverses order of sequence elements in-place */
//CVAPI(void) cvSeqInvert( CvSeq* seq );
(* procedure cvSeqInvert( seq:pCvSeq );cdecl; *)

{ ****************************************************************************************
  *                                     Drawing                                          *
  **************************************************************************************** }

// Following declaration is a macro definition!
function CV_RGB(const r, g, B: double): TCvScalar; {$IFDEF USE_INLINE} inline; {$ENDIF}

const
  CV_FILLED = -1;
{$EXTERNALSYM CV_FILLED}
  CV_AA = 16;
{$EXTERNALSYM CV_AA}
  { procedure cvLine(8: v1: ); shift CV_DEFAULT(0): Integer): Integer;
    CVAPI(void)  cvLine( pCvArr* img, CvPoint pt1, CvPoint pt2,
    CvScalar color, int thickness CV_DEFAULT(1),
    int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0) );
  }

(* procedure cvLine(img: pCvArr; pt1, pt2: TCvPoint; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl; *)

{ Draws a rectangle specified by a CvRect structure
  procedure cvRectangleR(8: v1: ); shift CV_DEFAULT(0): Integer): Integer;
}
(* procedure cvRectangle(img: pCvArr; pt1: TCvPoint; pt2: TCvPoint; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl; *)

{ Draws a circle with specified center and radius.
  Thickness works in the same way as with cvRectangle
  CVAPI(void)  cvCircle( pCvArr* img, CvPoint center, int radius,
  CvScalar color, int thickness CV_DEFAULT(1), int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0));
}
(* procedure cvCircle(img: pCvArr; center: TCvPoint; radius: Integer; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl; *)

{ Draws ellipse outline, filled ellipse, elliptic arc or filled elliptic sector,
  depending on <thickness>, <start_angle> and <end_angle> parameters. The resultant figure
  is rotated by <angle>. All the angles are in degrees

  CVAPI(void)  cvEllipse( pCvArr* img, CvPoint center, CvSize axes,
  double angle, double start_angle, double end_angle,
  CvScalar color, int thickness CV_DEFAULT(1),
  int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0));
}
(* procedure cvEllipse(img: pCvArr; center: TCvPoint; axes: TCvSize; angle: double; start_angle: double; nd_angle: double; color: TCvScalar;
  thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl; *)

{
CV_INLINE  void  cvEllipseBox( pCvArr* img, CvBox2D box, CvScalar color,
  int thickness CV_DEFAULT(1),
  int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0) )
}{
  CvSize axes;
  axes.width = cvRound(box.size.width*0.5);
  axes.height = cvRound(box.size.height*0.5);
  cvEllipse( img, cvPointFrom32f( box.center ), axes, box.angle,
  0, 360, color, thickness, line_type, shift );
}
procedure cvEllipseBox(img: pCvArr; box: TCvBox2D; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0);
{$IFDEF USE_INLINE} inline; {$ENDIF}
{
  Fills convex or monotonous polygon.
  CVAPI(void)  cvFillConvexPoly( pCvArr* img, const CvPoint* pts, int npts, CvScalar color,
  int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0));
}

(* procedure cvFillConvexPoly(img: pCvArr; const pts: pCVPoint; npts: Integer; color: TCvScalar; line_type: Integer = 8; shift: Integer = 0); cdecl; *)

{ Draws one or more polygonal curves
  CVAPI(void)  cvPolyLine( pCvArr* img, CvPoint** pts, const int* npts, int contours,
  int is_closed, CvScalar color, int thickness CV_DEFAULT(1),
  int line_type CV_DEFAULT(8), int shift CV_DEFAULT(0) );
}
(* procedure cvPolyLine(img: pCvArr; pts: pCVPoint; const npts: pInteger; contours: Integer; is_closed: Integer; color: TCvScalar; thickness: Integer = 1;
  line_type: Integer = 8; shift: Integer = 0); cdecl; *)

(*
  Clips the line segment connecting *pt1 and *pt2
  by the rectangular window
  (0<=x<img_size.width, 0<=y<img_size.height).

  CVAPI(int) cvClipLine( CvSize img_size, CvPoint* pt1, CvPoint* pt2 );
*)
(* function cvClipLine(img_size: TCvSize; pt1: pCVPoint; pt2: pCVPoint): Integer; cdecl; *)

(*
  Initializes line iterator. Initially, line_iterator->ptr will point
  to pt1 (or pt2, see left_to_right description) location in the image.
  Returns the number of pixels on the line between the ending points.

  CVAPI(int)  cvInitLineIterator( const CvArr* image, CvPoint pt1, CvPoint pt2,
  CvLineIterator* line_iterator,
  int connectivity CV_DEFAULT(8),
  int left_to_right CV_DEFAULT(0));
*)
(* function cvInitLineIterator(const image: pCvArr; pt1: TCvPoint; pt2: TCvPoint; line_iterator: pCvLineIterator; connectivity: Integer = 8;
  left_to_right: Integer = 0): Integer; cdecl; *)

{ basic font types }
const
  CV_FONT_HERSHEY_SIMPLEX = 0;
{$EXTERNALSYM CV_FONT_HERSHEY_SIMPLEX}
  CV_FONT_HERSHEY_PLAIN = 1;
{$EXTERNALSYM CV_FONT_HERSHEY_PLAIN}
  CV_FONT_HERSHEY_DUPLEX = 2;
{$EXTERNALSYM CV_FONT_HERSHEY_DUPLEX}
  CV_FONT_HERSHEY_COMPLEX = 3;
{$EXTERNALSYM CV_FONT_HERSHEY_COMPLEX}
  CV_FONT_HERSHEY_TRIPLEX = 4;
{$EXTERNALSYM CV_FONT_HERSHEY_TRIPLEX}
  CV_FONT_HERSHEY_COMPLEX_SMALL = 5;
{$EXTERNALSYM CV_FONT_HERSHEY_COMPLEX_SMALL}
  CV_FONT_HERSHEY_SCRIPT_SIMPLEX = 6;
{$EXTERNALSYM CV_FONT_HERSHEY_SCRIPT_SIMPLEX}
  CV_FONT_HERSHEY_SCRIPT_COMPLEX = 7;
{$EXTERNALSYM CV_FONT_HERSHEY_SCRIPT_COMPLEX}
  { font flags }
  CV_FONT_ITALIC = 16;
{$EXTERNALSYM CV_FONT_ITALIC}
  CV_FONT_VECTOR0 = CV_FONT_HERSHEY_SIMPLEX;
{$EXTERNALSYM CV_FONT_VECTOR0}
  { Font structure }

type
  pCvFont = ^TCvFont;

  TCvFont = record
    nameFont: pCvChar;
    color: TCvScalar;
    font_face: Integer;
    ascii: pInteger;
    greek: pInteger;
    cyrillic: pInteger;
    hscale, vscale: Single;
    shear: Single;
    thickness: Integer;
    dx: Single;
    line_type: Integer;
  end;

  { Initializes font structure used further in cvPutText
    CVAPI(void) cvInitFont(CvFont* font, int font_face,
    double hscale, double vscale, double shear CV_DEFAULT(0),
    int thickness CV_DEFAULT(1), int line_type CV_DEFAULT(8));
  }
(* procedure cvInitFont(font: pCvFont; font_face: Integer; hscale: double; vscale: double; shear: double = 0; thickness: Integer = 1;
  line_type: Integer = 8); cdecl; *)

function cvFont(scale: double; thickness: Integer = 1): TCvFont; {$IFDEF USE_INLINE} inline; {$ENDIF}
{ CVAPI(void)  cvPutText( pCvArr* img, const char* text, CvPoint org,
  const CvFont* font, CvScalar color );
}

(* procedure cvPutText(img: pCvArr; const text: pCvChar; org: TCvPoint; const font: pCvFont; color: TCvScalar); cdecl; *)

// * Calculates bounding box of text stroke (useful for alignment) */
// CVAPI(void)  cvGetTextSize( const char* text_string, const CvFont* font,
// CvSize* text_size, int* baseline );
(* procedure cvGetTextSize(const text_string: pCvChar; const font: pCvFont; text_size: pCvSize; var baseline: Integer); cdecl; *)

(*
  Unpacks color value, if arrtype is CV_8UC?, <color> is treated as
  packed color value, otherwise the first channels (depending on arrtype)
  of destination scalar are set to the same value = <color>

  CVAPI(CvScalar)  cvColorToScalar( double packed_color, int arrtype );
*)
(* function cvColorToScalar(packed_color: double; arrtype: Integer): TCvScalar; cdecl; *)

(*
  Returns the polygon points which make up the given ellipse.  The ellipse is define by
  the box of size 'axes' rotated 'angle' around the 'center'.  A partial sweep
  of the ellipse arc can be done by spcifying arc_start and arc_end to be something
  other than 0 and 360, respectively.  The input array 'pts' must be large enough to
  hold the result.  The total number of points stored into 'pts' is returned by this
  function.

  CVAPI(int) cvEllipse2Poly( CvPoint center, CvSize axes,
  int angle, int arc_start, int arc_end, CvPoint * pts, int delta );
*)
(* function cvEllipse2Poly(center: TCvPoint; axes: TCvSize; angle: Integer; arc_start: Integer; arc_end: Integer; pts: pCVPoint; delta: Integer): Integer; cdecl; *)

{ Draws contour outlines or filled interiors on the image
  CVAPI(void)  cvDrawContours( pCvArr *img, CvSeq* contour,
  CvScalar external_color, CvScalar hole_color,
  int max_level, int thickness CV_DEFAULT(1),
  int line_type CV_DEFAULT(8),
  CvPoint offset CV_DEFAULT(cvPoint(0,0)));
}
(* procedure cvDrawContours(img: pIplImage; contour: pCvSeq; external_color, hole_color: TCvScalar; max_level, thickness { =1 } , line_type: Integer { =8 };
  offset: TCvPoint { =cvPoint(0,0) } ); cdecl; *)

// ******************* Iteration through the sequence tree *****************/
type
  pCvTreeNodeIterator = ^TCvTreeNodeIterator;

  TCvTreeNodeIterator = record
    node: Pointer; // const void* node;
    level: Integer; // int level;
    max_level: Integer; // int max_level;
  end;

  // CVAPI(void) cvInitTreeNodeIterator( CvTreeNodeIterator* tree_iterator,const void* first, int max_level );
(* procedure cvInitTreeNodeIterator(var tree_iterator: TCvTreeNodeIterator; const first: Pointer; max_level: Integer); cdecl; *)
// CVAPI(void*) cvNextTreeNode( CvTreeNodeIterator* tree_iterator );

(* function cvNextTreeNode(tree_iterator: pCvTreeNodeIterator): Pointer; cdecl; *)
// CVAPI(void*) cvPrevTreeNode( CvTreeNodeIterator* tree_iterator );

(* function cvPrevTreeNode(tree_iterator: pCvTreeNodeIterator): Pointer; cdecl; *)

// * Inserts sequence into tree with specified "parent" sequence.
// If parent is equal to frame (e.g. the most external contour),
// then added contour will have null pointer to parent. */
// CVAPI(void) cvInsertNodeIntoTree( void* node, void* parent, void* frame );
(* procedure cvInsertNodeIntoTree(node: Pointer; parent: Pointer; frame: Pointer); cdecl; *)

// * Removes contour from tree (together with the contour children). */
// CVAPI(void) cvRemoveNodeFromTree( void* node, void* frame );
(* procedure cvRemoveNodeFromTree(node: Pointer; frame: Pointer); cdecl; *)

// * Gathers pointers to all the sequences,
// accessible from the <first>, to the single sequence */
// CVAPI(CvSeq*) cvTreeToNodeSeq( const void* first, int header_size,CvMemStorage* storage );
(* function cvTreeToNodeSeq(const first: Pointer; header_size: Integer; storage: pCvMemStorage): pCvSeq; cdecl; *)

(*
  The function implements the K-means algorithm for clustering an array of sample
  vectors in a specified number of classes

  CVAPI(int) cvKMeans2( const CvArr* samples, int cluster_count, CvArr* labels,
  CvTermCriteria termcrit, int attempts CV_DEFAULT(1),
  CvRNG* rng CV_DEFAULT(0), int flags CV_DEFAULT(0),
  CvArr* _centers CV_DEFAULT(0), double* compactness CV_DEFAULT(0) );
*)
const
  CV_KMEANS_USE_INITIAL_LABELS = 1;

(* function cvKMeans2(const samples: pCvArr; cluster_count: Integer; labels: pCvArr; termcrit: TCvTermCriteria; attempts: Integer = 1; rng: pCvRNG = nil;
  flags: Integer = 0; _centers: pCvArr = nil; compactness: pDouble = nil): Integer; cdecl; *)

(*
  ***************************************************************************************\
  *                                    System functions                                    *
  \***************************************************************************************
*)
(*
  Add the function pointers table with associated information to the IPP primitives list

  CVAPI(int)  cvRegisterModule( const CvModuleInfo* module_info );
*)
(* function cvRegisterModule(const module_info: pCvModuleInfo): Integer; cdecl; *)
(*
  Loads optimized functions from IPP, MKL etc. or switches back to pure C code

  CVAPI(int)  cvUseOptimized( int on_off );
*)

(* function cvUseOptimized(on_off: Integer): Integer; cdecl; *)
(*
  Retrieves information about the registered modules and loaded optimized plugins

  CVAPI(void)  cvGetModuleInfo( const char* module_name,
  const char** version,
  const char** loaded_addon_plugins );
*)

(* procedure cvGetModuleInfo(const module_name: pCvChar; const version: ppCvChar; const loaded_addon_plugins: ppCvChar); cdecl; *)

type
  (* typedef  void* (CV_CDECL *CvAllocFunc)(size_t size, void* userdata); *)
  TCvAllocFunc = function(size: size_t; userdata: Pointer): Pointer; cdecl;
  (* typedef  int (CV_CDECL *CvFreeFunc)(void* pptr, void* userdata); *)

  TCvFreeFunc = function(pptr: Pointer; userdata: Pointer): Integer; cdecl;
  (*
    Set user-defined memory managment functions (substitutors for malloc and free) that
    will be called by cvAlloc, cvFree and higher-level functions (e.g. cvCreateImage)

    CVAPI(void) cvSetMemoryManager( CvAllocFunc alloc_func CV_DEFAULT(NULL),
    CvFreeFunc free_func CV_DEFAULT(NULL),
    void* userdata CV_DEFAULT(NULL));
  *)

(* procedure cvSetMemoryManager(alloc_func: TCvAllocFunc = nil; free_func: TCvFreeFunc = nil; userdata: Pointer = nil); cdecl; *)

type
  (* typedef  IplImage* (CV_STDCALL* Cv_iplCreateImageHeader)
    (int,int,int,char*,char*,int,int,int,int,int,
    IplROI*,IplImage*,void*,IplTileInfo *)
  TCv_iplCreateImageHeader = function(A: Integer; B: Integer; C: Integer; D: pCvChar; E: pCvChar; F: Integer; g: Integer; H: Integer; i: Integer; j: Integer;
    K: pIplROI; L: pIplImage; M: Pointer; N: PIplTileInfo): pIplImage; stdcall;

  (* typedef  void (CV_STDCALL* Cv_iplAllocateImageData)(IplImage*,int,int); *)
  TCv_iplAllocateImageData = procedure(A: pIplImage; B: Integer); stdcall;
  (* typedef  void (CV_STDCALL* Cv_iplDeallocate)(IplImage*,int); *)

  TCv_iplDeallocate = procedure(A: pIplImage; B: Integer); stdcall;
  (* typedef  IplROI* (CV_STDCALL* Cv_iplCreateROI)(int,int,int,int,int); *)

  TCv_iplCreateROI = function(const A: pIplImage): pIplROI; stdcall;
  (* typedef  IplImage* (CV_STDCALL* Cv_iplCloneImage)(const IplImage *)

  TCv_iplCloneImage = function(const A: pIplImage): pIplImage; stdcall;

  (*
    Makes OpenCV use IPL functions for IplImage allocation/deallocation

    CVAPI(void) cvSetIPLAllocators( Cv_iplCreateImageHeader create_header,
    Cv_iplAllocateImageData allocate_data,
    Cv_iplDeallocate deallocate,
    Cv_iplCreateROI create_roi,
    Cv_iplCloneImage clone_image );
  *)
(* procedure cvSetIPLAllocators(create_header: TCv_iplCreateImageHeader; allocate_data: TCv_iplAllocateImageData; deallocate: TCv_iplDeallocate;
  create_roi: TCv_iplCreateROI; clone_image: TCv_iplCloneImage); cdecl; *)

{ ****************************************************************************************
  *                                    Data Persistence                                  *
  **************************************************************************************** }

{ ********************************* High-level functions ********************************* }

{ opens existing or creates new file storage
  CVAPI(CvFileStorage*)  cvOpenFileStorage( const char* filename, CvMemStorage* memstorage,
  int flags, const char* encoding CV_DEFAULT(NULL) );
}
(* function cvOpenFileStorage(const filename: pCvChar; memstorage: pCvMemStorage; flags: Integer; const encoding: pCvChar = nil): pCvFileStorage; cdecl; *)

{ closes file storage and deallocates buffers
  CVAPI(void) cvReleaseFileStorage( CvFileStorage** fs );
}
(* procedure cvReleaseFileStorage(var fs: pCvFileStorage); cdecl; *)

(*
  returns attribute value or 0 (NULL) if there is no such attribute

  CVAPI(const char* ) cvAttrValue( const CvAttrList* attr, const char* attr_name );
*)
(* function cvAttrValue(const attr: pCvAttrList; const attr_name: pCvChar): pCvChar; cdecl; *)

//* starts writing compound structure (map or sequence) */
//CVAPI(void) cvStartWriteStruct( CvFileStorage* fs, const char* name,
//                                int struct_flags, const char* type_name CV_DEFAULT(NULL),
//                                CvAttrList attributes CV_DEFAULT(cvAttrList()));
(* procedure cvStartWriteStruct( fs:pCvFileStorage; const name:pCVChar;
                                struct_flags:Integer; const type_name :pCVChar;
                                attributes:TCvAttrList); cdecl; *)

//* finishes writing compound structure */
//CVAPI(void) cvEndWriteStruct( CvFileStorage* fs );
(* procedure cvEndWriteStruct(fs:pCvFileStorage );cdecl; *)

{ this is a slower version of cvGetFileNode that takes the key as a literal string
  CVAPI(CvFileNode*) cvGetFileNodeByName( const CvFileStorage* fs,
  const CvFileNode* map, const char* name );
}
(* function cvGetFileNodeByName(const fs: pCvFileStorage; const map: pCvFileNode; const name: pCvChar): pCvFileNode; cdecl; *)

{ CV_INLINE int cvReadInt( const CvFileNode* node, int default_value CV_DEFAULT(0) )
  return !node ? default_value :
  CV_NODE_IS_INT(node->tag) ? node->data.i :
  CV_NODE_IS_REAL(node->tag) ? cvRound(node->data.f) : 0x7fffffff;
}
function cvReadInt(const node: pCvFileNode; default_value: Integer = 0): Integer; {$IFDEF USE_INLINE} inline; {$ENDIF}
{ CV_INLINE int cvReadIntByName( const CvFileStorage* fs, const CvFileNode* map,
  const char* name, int default_value CV_DEFAULT(0) )
}{
  return cvReadInt( cvGetFileNodeByName( fs, map, name ), default_value );
}

function cvReadIntByName(const fs: pCvFileStorage; const map: pCvFileNode; const name: pCvChar; default_value: Integer = 0): Integer;
{$IFDEF USE_INLINE} inline; {$ENDIF}
{
 CV_INLINE const char* cvReadString( const CvFileNode* node,
 const char* default_value CV_DEFAULT(NULL) )
 }{
 return !node ? default_value : CV_NODE_IS_STRING(node->tag) ? node->data.str.ptr : 0;
}

function cvReadString(const node: pCvFileNode; const default_value: pCvChar = nil): pCvChar; {$IFDEF USE_INLINE} inline;
{$ENDIF}
{
 CV_INLINE const char* cvReadStringByName( const CvFileStorage* fs, const CvFileNode* map,
 const char* name, const char* default_value CV_DEFAULT(NULL) )
 }{
 return cvReadString( cvGetFileNodeByName( fs, map, name ), default_value );
 }

function cvReadStringByName(const fs: pCvFileStorage; const map: pCvFileNode; const name: pCvChar; const default_value: pCvChar = nil): pCvChar;
{$IFDEF USE_INLINE} inline; {$ENDIF}
{
  decodes standard or user-defined object and returns it
  CVAPI(void*) cvRead( CvFileStorage* fs, CvFileNode* node,
  CvAttrList* attributes CV_DEFAULT(NULL));
}

(* function cvRead(fs: pCvFileStorage; node: pCvFileNode; attributes: pCvAttrList = nil): pPointer; cdecl; *)

// * decodes standard or user-defined object and returns it */
// CV_INLINE void* cvReadByName( CvFileStorage* fs, const CvFileNode* map, const char* name, CvAttrList* attributes CV_DEFAULT(NULL) )
// {return cvRead( fs, cvGetFileNodeByName( fs, map, name ), attributes );}
function cvReadByName(fs: pCvFileStorage; const map: pCvFileNode; const name: pCvChar; attributes: pCvAttrList = nil): Pointer;

(*
  starts reading data from sequence or scalar numeric node

  CVAPI(void) cvStartReadRawData( const CvFileStorage* fs, const CvFileNode* src,
  CvSeqReader* reader );
*)
(* procedure cvStartReadRawData(const fs: pCvFileStorage; const src: pCvFileNode; reader: pCvSeqReader); cdecl; *)
(*
  reads multiple numbers and stores them to array

  CVAPI(void) cvReadRawDataSlice( const CvFileStorage* fs, CvSeqReader* reader,
  int count, void* dst, const char* dt );
*)

(* procedure cvReadRawDataSlice(const fs: pCvFileStorage; reader: pCvSeqReader; count: Integer; dst: Pointer; const dt: pCvChar); cdecl; *)
(*
  combination of two previous functions for easier reading of whole sequences

  CVAPI(void) cvReadRawData( const CvFileStorage* fs, const CvFileNode* src,
  void* dst, const char* dt );
*)

(* procedure cvReadRawData(const fs: pCvFileStorage; const src: pCvFileNode; dst: Pointer; const dt: pCvChar); cdecl; *)
(*
  writes a copy of file node to file storage

  CVAPI(void) cvWriteFileNode( CvFileStorage* fs, const char* new_node_name,
  const CvFileNode* node, int embed );
*)

(* procedure cvWriteFileNode(fs: pCvFileStorage; const new_node_name: pCvChar; const node: pCvFileNode; embed: Integer); cdecl; *)
(*
  returns name of file node
*)
(*
  CVAPI(const char* ) cvGetFileNodeName( const CvFileNode* node );
*)

(* function cvGetFileNodeName(const node: pCvFileNode): pCvChar; cdecl; *)

{ *********************************** Adding own types *********************************** }

(*
  CVAPI(void) cvRegisterType( const CvTypeInfo* info );
*)
(* procedure cvRegisterType(const info: pCvTypeInfo); cdecl; *)
(*
  CVAPI(void) cvUnregisterType( const char* type_name );
*)

(* procedure cvUnregisterType(const type_name: pCvChar); cdecl; *)
(*
  CVAPI(CvTypeInfo* ) cvFirstType(void);
*)

(* function cvFirstType: pCvTypeInfo; cdecl; *)
(*
  CVAPI(CvTypeInfo* ) cvFindType( const char* type_name );
*)

(* function cvFindType(const type_name: pCvChar): pCvTypeInfo; cdecl; *)
(*
  CVAPI(CvTypeInfo* ) cvTypeOf( const void* struct_ptr );
*)

(* function cvTypeOf(const struct_ptr: Pointer): pCvTypeInfo; cdecl; *)

// * universal functions */
// CVAPI(void) cvRelease( void** struct_ptr );
(* procedure cvRelease(var struct_ptr: Pointer); cdecl; overload; *)

(* procedure cvRelease(var struct_ptr: pCvSeq); cdecl; overload; *)

(*
  CVAPI(void* ) cvClone( const void* struct_ptr );
*)
(* function cvClone(const struct_ptr: Pointer): Pointer; cdecl; *)

{
  simple API for reading/writing data
  CVAPI(void) cvSave( const char* filename,
  const void* struct_ptr,
  const char* name CV_DEFAULT(NULL),
  const char* comment CV_DEFAULT(NULL),
  CvAttrList attributes CV_DEFAULT(cvAttrList()));
  CVAPI(void*) cvLoad( const char* filename,
  CvMemStorage* memstorage CV_DEFAULT(NULL),
  const char* name CV_DEFAULT(NULL),
  const char** real_name CV_DEFAULT(NULL) );
}

(* procedure cvSave(const filename: pCvChar; const struct_ptr: Pointer; const name: pCvChar; const comment: pCvChar; attributes: TCvAttrList); cdecl; overload; *)

(* procedure cvSave(const filename: pCvChar; const struct_ptr: Pointer; const name: pCvChar = Nil; const comment: pCvChar = Nil); overload; *)
{$IFDEF USE_INLINE} inline; {$ENDIF}
(* function cvLoad(const filename: pCvChar; memstorage: pCvMemStorage = Nil; const name: pCvChar = nil; const real_name: ppCvChar = nil): Pointer; cdecl; *)

{ *********************************** Measuring Execution Time *************************** }

{ helper functions for RNG initialization and accurate time measurement:
  uses internal clock counter on x86 }
(* function cvGetTickCount: int64; cdecl; *) // {$IFDEF USE_INLINE}inline; {$ENDIF}

(* function cvGetTickFrequency: double; cdecl; *)

// *********************************** CPU capabilities ***********************************/
// CVAPI(int) cvCheckHardwareSupport(int feature);
(* function cvCheckHardwareSupport(feature: Integer): Integer; cdecl; *)

// *********************************** Multi-Threading ************************************/

// * retrieve/set the number of threads used in OpenMP implementations */
// CVAPI(int)  cvGetNumThreads( void );
(* function cvGetNumThreads: Integer; cdecl; *)
// CVAPI(void) cvSetNumThreads( int threads CV_DEFAULT(0) );

(* procedure cvSetNumThreads(threads: Integer = 0); cdecl; *)
// * get index of the thread being executed */
// CVAPI(int)  cvGetThreadNum( void );

(* function cvGetThreadNum: Integer; cdecl; *)

const
  CV_CPU_NONE             = 0;
  CV_CPU_MMX              = 1;
  CV_CPU_SSE              = 2;
  CV_CPU_SSE2             = 3;
  CV_CPU_SSE3             = 4;
  CV_CPU_SSSE3            = 5;
  CV_CPU_SSE4_1           = 6;
  CV_CPU_SSE4_2           = 7;
  CV_CPU_POPCNT           = 8;
  CV_CPU_AVX              = 10;
  CV_CPU_AVX2             = 11;
  CV_HARDWARE_MAX_FEATURE = 255;

  // ********************************** Error Handling **************************************/

  // * Get current OpenCV error status */
  // CVAPI(int) cvGetErrStatus( void );
(* function cvGetErrStatus: Integer; cdecl; *)

// * Sets error status silently */
// CVAPI(void) cvSetErrStatus( int status );
(* procedure cvSetErrStatus(status: Integer); cdecl; *)

const
  CV_ErrModeLeaf   = 0; // * Print error and exit program */
  CV_ErrModeParent = 1; // * Print error and continue */
  CV_ErrModeSilent = 2; // * Don't print and continue */

  // * Retrives current error processing mode */
  // CVAPI(int)  cvGetErrMode( void );

(* function cvGetErrMode: Integer; cdecl; *)

// * Sets error processing mode, returns previously used mode */
// CVAPI(int) cvSetErrMode( int mode );
(* function cvSetErrMode(mode: Integer): Integer; cdecl; *)

(* Sets error status and performs some additonal actions (displaying message box,
  writing message to stderr, terminating application etc.)
  depending on the current error mode *)
// CVAPI(void) cvError( int status, const char* func_name,const char* err_msg, const char* file_name, int line );
(* procedure cvError(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar = nil; line: Integer = 0); cdecl; *)

(*
  Retrieves textual description of the error given its code

  CVAPI(const char* ) cvErrorStr( int status );
*)
(* function cvErrorStr(status: Integer): pCvChar; cdecl; *)
(*
  Retrieves detailed information about the last error occured

  CVAPI(int) cvGetErrInfo( const char** errcode_desc, const char** description,
  const char** filename, int* line );
*)

(* function cvGetErrInfo(const errcode_desc: ppCvChar; const description: ppCvChar; const filename: ppCvChar; line: pInteger): Integer; cdecl; *)
(*
  Maps IPP error codes to the counterparts from OpenCV

  CVAPI(int) cvErrorFromIppStatus( int ipp_status );
*)

(* function cvErrorFromIppStatus(ipp_status: Integer): Integer; cdecl; *)

type
  (* typedef  int (CV_CDECL *CvErrorCallback)( int status, const char* func_name,
    const char* err_msg, const char* file_name, int line, void* userdata ); *)
  TCvErrorCallback = function(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer)
    : Integer; cdecl;

  (*
    Assigns a new error-handling function

    CVAPI(CvErrorCallback) cvRedirectError( CvErrorCallback error_handler,
    void* userdata CV_DEFAULT(NULL),
    void** prev_userdata CV_DEFAULT(NULL) );
  *)
(* function cvRedirectError(error_handler: TCvErrorCallback; userdata: Pointer = nil; prev_userdata: ppvoid = nil): TCvErrorCallback; cdecl; *)

(*

  Output to:
  cvNulDevReport - nothing
  cvStdErrReport - console(fprintf(stderr,...))
  cvGuiBoxReport - MessageBox(WIN32)

*)
(*
  CVAPI(int) cvNulDevReport( int status, const char* func_name, const char* err_msg,
  const char* file_name, int line, void* userdata );
*)
(* function cvNulDevReport(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer)
  : Integer; cdecl; *)
(*
  CVAPI(int) cvStdErrReport( int status, const char* func_name, const char* err_msg,
  const char* file_name, int line, void* userdata );
*)

(* function cvStdErrReport(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer)
  : Integer; cdecl; *)
(*
  CVAPI(int) cvGuiBoxReport( int status, const char* func_name, const char* err_msg,
  const char* file_name, int line, void* userdata );
*)

(* function cvGuiBoxReport(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer)
  : Integer; cdecl; *)

// defined in compat.hpp
(* procedure cvCvtPixToPlane(const src: pCvArr; dst0: pCvArr; dst1: pCvArr; dst2: pCvArr; dst3: pCvArr); cdecl; *)
(* procedure cvCvtPlaneToPix(const src0: pCvArr; const src1: pCvArr; const src2: pCvArr; const src3: pCvArr; dst: pCvArr); cdecl; *)

type
  TcvAlloc = function(size: NativeUInt): Pointer; cdecl;
  TcvAttrValue = function(const attr: pCvAttrList; const attr_name: pCvChar): pCvChar; cdecl;
  TcvAvg = function(const arr: pCvArr; const mask: pCvArr = nil): TCvScalar; cdecl;
  TcvCbrt = function(value: Float): Float; cdecl;
  TcvCheckArr = function(const arr: pCvArr; flags: Integer = 0; min_val: double = 0; max_val: double = 0): Integer; cdecl;
  TcvCheckHardwareSupport = function(feature: Integer): Integer; cdecl;
  TcvCheckTermCriteria = function(criteria: TCvTermCriteria; default_eps: double; default_max_iters: Integer): TCvTermCriteria; cdecl;
  TcvClipLine = function(img_size: TCvSize; pt1: pCVPoint; pt2: pCVPoint): Integer; cdecl;
  TcvClone = function(const struct_ptr: Pointer): Pointer; cdecl;
  TcvCloneGraph = function(const graph: pCvGraph; storage: pCvMemStorage): pCvGraph; cdecl;
  TcvCloneImage = function(const image: pIplImage): pIplImage; cdecl;
  TcvCloneMat = function(const mat: pCvMat): pCvMat; cdecl;
  TcvCloneMatND = function(const mat: pCvMatND): pCvMatND; cdecl;
  TcvCloneSparseMat = function(const mat: pCvSparseMat): pCvSparseMat; cdecl;
  TcvColorToScalar = function(packed_color: double; arrtype: Integer): TCvScalar; cdecl;
  TcvCountNonZero = function(arr: pIplImage): Integer; cdecl;
  TcvCreateChildMemStorage = function(parent: pCvMemStorage): pCvMemStorage; cdecl;
  TcvCreateGraph = function(graph_flags: Integer; header_size: Integer; vtx_size: Integer; edge_size: Integer; storage: pCvMemStorage): pCvGraph; cdecl;
  TcvCreateGraphScanner = function(graph: pCvGraph; vtx: pCvGraphVtx = nil; mask: Integer = CV_GRAPH_ALL_ITEMS): pCvGraphScanner; cdecl;
  TcvCreateImage = function(size: TCvSize; depth, channels: Integer): pIplImage; cdecl;
  TcvCreateImageHeader = function(size: TCvSize; depth: Integer; channels: Integer): pIplImage; cdecl;
  TcvCreateMat = function(rows, cols, cType: Integer): pCvMat; cdecl;
  TcvCreateMatHeader = function(rows: Integer; cols: Integer; cType: Integer): pCvMat; cdecl;
  TcvCreateMatND = function(dims: Integer; const sizes: pInteger; cType: Integer): pCvMatND; cdecl;
  TcvCreateMatNDHeader = function(dims: Integer; const sizes: pInteger; cType: Integer): pCvMatND; cdecl;
  TcvCreateMemStorage = function(block_size: Integer = 0): pCvMemStorage; cdecl;
  TcvCreateSeq = function(seq_flags: Integer; header_size: NativeUInt; elem_size: NativeUInt; storage: pCvMemStorage): pCvSeq; cdecl;
  TcvCreateSet = function(set_flags: Integer; header_size: Integer; elem_size: Integer; storage: pCvMemStorage): pCvSet; cdecl;
  TcvCreateSparseMat = function(dims: Integer; sizes: pInteger; cType: Integer): pCvSparseMat; cdecl;
  TcvDet = function(const mat: pCvArr): double; cdecl;
  TcvDotProduct = function(const src1, src2: pCvArr): double; cdecl;
  TcvEllipse2Poly = function(center: TCvPoint; axes: TCvSize; angle: Integer; arc_start: Integer; arc_end: Integer; pts: pCVPoint; delta: Integer): Integer; cdecl;
  TcvEndWriteSeq = function(writer: pCvSeqWriter): pCvSeq; cdecl;
  TcvErrorFromIppStatus = function(ipp_status: Integer): Integer; cdecl;
  TcvErrorStr = function(status: Integer): pCvChar; cdecl;
  TcvFastArctan = function(y, x: Float): Float; cdecl;
  TcvFindGraphEdge = function(const graph: pCvGraph; start_idx: Integer; end_idx: Integer): pCvGraphEdge; cdecl;
  TcvFindGraphEdgeByPtr = function(const graph: pCvGraph; const start_vtx: pCvGraphVtx; const end_vtx: pCvGraphVtx): pCvGraphEdge; cdecl;
  TcvFindType = function(const type_name: pCvChar): pCvTypeInfo; cdecl;
  TcvFirstType = function: pCvTypeInfo; cdecl;
  TcvGet1D = function(const arr: pCvArr; idx0: Integer): TCvScalar; cdecl;
  TcvGet2D = function(const arr: pCvMat; idx0, idx1: Integer): TCvScalar; cdecl;
  TcvGet3D = function(const arr: pCvArr; idx0, idx1, idx2: Integer): TCvScalar; cdecl;
  TcvGetCols = function(const arr: pCvArr; submat: pCvMat; start_col, end_col: Integer): pCvMat; cdecl;
  TcvGetDiag = function(const arr: pCvArr; submat: pCvMat; diag: Integer = 0): pCvMat; cdecl;
  TcvGetDims = function(const arr: pCvArr; sizes: pInteger = nil): Integer; cdecl;
  TcvGetDimSize = function(const arr: pCvArr; index: Integer): Integer; cdecl;
  TcvGetElemType = function(const arr: pCvArr): Integer; cdecl;
  TcvGetErrInfo = function(const errcode_desc: ppCvChar; const description: ppCvChar; const filename: ppCvChar; line: pInteger): Integer; cdecl;
  TcvGetErrMode = function: Integer; cdecl;
  TcvGetErrStatus = function: Integer; cdecl;
  TcvGetFileNode = function(fs: pCvFileStorage; map: pCvFileNode; const key: pCvStringHashNode; create_missing: Integer = 0): pCvFileNode; cdecl;
  TcvGetFileNodeByName = function(const fs: pCvFileStorage; const map: pCvFileNode; const name: pCvChar): pCvFileNode; cdecl;
  TcvGetFileNodeName = function(const node: pCvFileNode): pCvChar; cdecl;
  TcvGetHashedKey = function(fs: pCvFileStorage; const name: pCvChar; len: Integer = -1; create_missing: Integer = 0): pCvStringHashNode; cdecl;
  TcvGetImage = function(const arr: pCvArr; image_header: pIplImage): pIplImage; cdecl;
  TcvGetImageCOI = function(const image: pIplImage): Integer; cdecl;
  TcvGetImageROI = function(const image: pIplImage): TCvRect; cdecl;
  TcvGetMat = function(const arr: pCvArr; header: pCvMat; coi: pInteger = nil; allowND: Integer = 0): pCvMat; cdecl;
  TcvGetND = function(const arr: pCvArr; idx: pInteger): TCvScalar; cdecl;
  TcvGetNumThreads = function: Integer; cdecl;
  TcvGetOptimalDFTSize = function(size0: Integer): Integer; cdecl;
  TcvGetReal1D = function(const arr: pIplImage; idx0: Integer): double; cdecl;
  TcvGetReal2D = function(const arr: pCvMat; idx0, idx1: Integer): double; cdecl;
  TcvGetReal3D = function(const arr: pCvArr; idx0, idx1, idx2: Integer): double; cdecl;
  TcvGetRealND = function(const arr: pCvArr; idx: pInteger): double; cdecl;
  TcvGetRootFileNode = function(const fs: pCvFileStorage; stream_index: Integer = 0): pCvFileNode; cdecl;
  TcvGetRows = function(const arr: pCvArr; submat: pCvMat; start_row, end_row: Integer; delta_row: Integer = 1): pCvMat; cdecl;
  TcvGetSeqElem = function(const seq: pCvSeq; index: Integer): Pointer; cdecl;
  TcvGetSeqReaderPos = function(reader: pCvSeqReader): Integer; cdecl;
  TcvGetSize = function(const arr: pCvArr): TCvSize;
  TcvGetSubArr = function(arr: pCvArr; submat: pCvArr; rect: TCvRect): pCvMat; cdecl;
  TcvGetSubRect = function(arr: pCvArr; submat: pCvArr; rect: TCvRect): pCvMat; cdecl;
  TcvGetThreadNum = function: Integer; cdecl;
  TcvGetTickCount = function: int64; cdecl;
  TcvGetTickFrequency = function: double; cdecl;
  TcvGraphAddEdge = function(graph: pCvGraph; start_idx: Integer; end_idx: Integer; const edge: pCvGraphEdge = nil; inserted_edge: pCvGraphEdgeArray = nil): Integer; cdecl;
  TcvGraphAddEdgeByPtr = function(graph: pCvGraph; start_vtx: pCvGraphVtx; end_vtx: pCvGraphVtx; const edge: pCvGraphEdge = nil; inserted_edge: pCvGraphEdgeArray = nil): Integer; cdecl;
  TcvGraphAddVtx = function(graph: pCvGraph; const vtx: pCvGraphVtx = nil; inserted_vtx: pCvGraphVtxArray = nil): Integer; cdecl;
  TcvGraphRemoveVtx = function(graph: pCvGraph; index: Integer): Integer; cdecl;
  TcvGraphRemoveVtxByPtr = function(graph: pCvGraph; vtx: pCvGraphVtx): Integer; cdecl;
  TcvGraphVtxDegree = function(const graph: pCvGraph; vtx_idx: Integer): Integer; cdecl;
  TcvGraphVtxDegreeByPtr = function(const graph: pCvGraph; const vtx: pCvGraphVtx): Integer; cdecl;
  TcvGuiBoxReport = function(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer): Integer; cdecl;
  TcvInitImageHeader = function(image: pIplImage; size: TCvSize; depth: Integer; channels: Integer; origin: Integer = 0; align: Integer = 4): pIplImage; cdecl;
  TcvInitLineIterator = function(const image: pCvArr; pt1: TCvPoint; pt2: TCvPoint; line_iterator: pCvLineIterator; connectivity: Integer = 8; left_to_right: Integer = 0): Integer; cdecl;
  TcvInitMatHeader = function(mat: pCvMat; rows: Integer; cols: Integer; _type: Integer; data: Pointer = nil; step: Integer = CV_AUTOSTEP): pCvMat; cdecl;
  TcvInitMatNDHeader = function(mat: pCvMatND; dims: Integer; const sizes: pInteger; cType: Integer; data: pCvArr = nil): pCvMatND; cdecl;
  TcvInitNArrayIterator = function(count: Integer; arrs: pCvArr; const mask: pCvArr; stubs: pCvMatND; array_iterator: pCvNArrayIterator; flags: Integer = 0): Integer; cdecl;
  TcvInitSparseMatIterator = function(const mat: pCvSparseMat; mat_iterator: pCvSparseMatIterator): pCvSparseNode; cdecl;
  TcvInvert = function(const src: pCvArr; dst: pCvArr; method: Integer = CV_LU): double; cdecl;
  TcvKMeans2 = function(const samples: pCvArr; cluster_count: Integer; labels: pCvArr; termcrit: TCvTermCriteria; attempts: Integer = 1; rng: pCvRNG = nil; flags: Integer = 0; _centers: pCvArr = nil; compactness: pDouble = nil): Integer; cdecl;
  TcvLoad = function(const filename: pCvChar; memstorage: pCvMemStorage = Nil; const name: pCvChar = nil; const real_name: ppCvChar = nil): Pointer; cdecl;
  TcvMahalanobis = function(const vec1: pCvArr; const vec2: pCvArr; const mat: pCvArr): double; cdecl;
  TcvMakeSeqHeaderForArray = function(seq_type: Integer; header_size: Integer; elem_size: Integer; elements: Pointer; total: Integer; seq: pCvSeq; block: pCvSeqBlock): pCvSeq; cdecl;
  TcvMemStorageAlloc = function(storage: pCvMemStorage; size: size_t): Pointer; cdecl;
  TcvMemStorageAllocString = function(storage: pCvMemStorage; const ptr: pCvChar; len: Integer = -1): TCvString; cdecl;
  TcvNextGraphItem = function(scanner: pCvGraphScanner): Integer; cdecl;
  TcvNextNArraySlice = function(array_iterator: pCvNArrayIterator): Integer; cdecl;
  TcvNextTreeNode = function(tree_iterator: pCvTreeNodeIterator): Pointer; cdecl;
  TcvNorm = function(const arr1: pCvArr; const arr2: pCvArr = nil; norm_type: Integer = CV_L2; const mask: pCvArr = nil): double; cdecl;
  TcvNulDevReport = function(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer): Integer; cdecl;
  TcvOpenFileStorage = function(const filename: pCvChar; memstorage: pCvMemStorage; flags: Integer; const encoding: pCvChar = nil): pCvFileStorage; cdecl;
  TcvPrevTreeNode = function(tree_iterator: pCvTreeNodeIterator): Pointer; cdecl;
  TcvPtr1D = function(const arr: pCvArr; idx0: Integer; cType: pInteger = nil): pCvArr; cdecl;
  TcvPtr2D = function(const arr: pCvArr; idx0, idx1: Integer; cType: pInteger = nil): pCvArr; cdecl;
  TcvPtr3D = function(const arr: pCvArr; idx0, idx1, idx2: Integer; cType: pInteger = nil): pCvArr; cdecl;
  TcvPtrND = function(const arr: pCvArr; idx: pInteger; cType: pInteger = nil; create_node: Integer = 1; precalc_hashval: punsigned = nil): pCvArr; cdecl;
  TcvRange = function(mat: pCvArr; start: double; end_: double): pCvArr; cdecl;
  TcvRead = function(fs: pCvFileStorage; node: pCvFileNode; attributes: pCvAttrList = nil): pPointer; cdecl;
  TcvRedirectError = function(error_handler: TCvErrorCallback; userdata: Pointer = nil; prev_userdata: ppvoid = nil): TCvErrorCallback; cdecl;
  TcvRegisterModule = function(const module_info: pCvModuleInfo): Integer; cdecl;
  TcvReshape = function(const arr: pCvArr; header: pCvMat; new_cn: Integer; new_rows: Integer = 0): pCvMat; cdecl;
  TcvReshapeMatND = function(const arr: pCvArr; sizeof_header: Integer; header: pCvArr; new_cn, new_dims: Integer; new_sizes: pInteger): pCvArr; cdecl;
  TcvSeqElemIdx = function(const seq: pCvSeq; const element: Pointer; block: pCvSeqBlockArray = nil): Integer; cdecl;
  TcvSeqInsert = function(seq: pCvSeq; before_index: Integer; const element: Pointer = nil): pschar; cdecl;
  TcvSeqPartition = function(const seq: pCvSeq; storage: pCvMemStorage; labels: pCvSeq; is_equal: TCvCmpFunc; userdata: Pointer): Integer; cdecl;
  TcvSeqPush = function(seq: pCvSeq; const element: Pointer = nil): Pointer; cdecl;
  TcvSeqPushFront = function(seq: pCvSeq; const element: Pointer = nil): pschar; cdecl;
  TcvSeqSearch = function(seq: pCvSeq; const elem: Pointer; func: TCvCmpFunc; is_sorted: Integer; elem_idx: pInteger; userdata: Pointer = nil): pschar; cdecl;
  TcvSeqSlice = function(const seq: pCvSeq; slice: TCvSlice; storage: pCvMemStorage = nil; copy_data: Integer = 0): pCvSeq; cdecl;
  TcvSetAdd = function(set_header: pCvSet; elem: pCvSetElem = nil; inserted_elem: pCvSetElemArray = nil): Integer; cdecl;
  TcvSetErrMode = function(mode: Integer): Integer; cdecl;
  TcvSliceLength = function(slice: TCvSlice; const seq: pCvSeq): Integer; cdecl;
  TcvSolve = function(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; method: Integer = CV_LU): Integer; cdecl;
  TcvSolveCubic = function(const coeffs: pCvMat; roots: pCvMat): Integer; cdecl;
  TcvStdErrReport = function(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer): Integer; cdecl;
  TcvSum = function(const arr: pCvArr): TCvScalar; cdecl;
  TcvTrace = function(const mat: pCvArr): TCvScalar; cdecl;
  TcvTreeToNodeSeq = function(const first: Pointer; header_size: Integer; storage: pCvMemStorage): pCvSeq; cdecl;
  TcvTypeOf = function(const struct_ptr: Pointer): pCvTypeInfo; cdecl;
  TcvUseOptimized = function(on_off: Integer): Integer; cdecl;
  T_cvGetSize = procedure(const arr: pCvArr; var size: TCvSize); cdecl;
  TcvAbsDiff = procedure(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl;
  TcvAbsDiffS = procedure(const src: pCvArr; dst: pCvArr;value:TCvScalar); cdecl;
  TcvAdd = procedure(const src1, src2: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl;
  TcvAddS = procedure(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil); cdecl;
  TcvAddWeighted = procedure(const src1: pIplImage; alpha: double; const src2: pIplImage; beta: double; gamma: double; dst: pIplImage); cdecl;
  TcvAnd = procedure(const src1: pIplImage; const src2: pIplImage; dst: pIplImage; masl: pIplImage = nil); cdecl;
  TcvAndS = procedure(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl;
  TcvAvgSdv = procedure(const arr: pCvArr; mean: pCvScalar; std_dev: pCvScalar; const mask: pCvArr = nil); cdecl;
  TcvBackProjectPCA = procedure(const proj: pCvArr; const mean: pCvArr; const eigenvects: pCvArr; result: pCvArr); cdecl;
  TcvCalcCovarMatrix = procedure(const vects: pCvArrArray; count: Integer; cov_mat: pCvArr; avg: pCvArr; flags: Integer); cdecl;
  TcvCalcPCA = procedure(const data: pCvArr; mean: pCvArr; eigenvals: pCvArr; eigenvects: pCvArr; flags: Integer); cdecl;
  TcvCartToPolar = procedure(const x: pCvArr; const y: pCvArr; magnitude: pCvArr; angle: pCvArr = nil; angle_in_degrees: Integer = 0); cdecl;
  TcvChangeSeqBlock = procedure(reader: pCvSeqReader; direction: Integer); cdecl;
  TcvCircle = procedure(img: pCvArr; center: TCvPoint; radius: Integer; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl;
  TcvClearGraph = procedure(graph: pCvGraph); cdecl;
  TcvClearMemStorage = procedure(storage: pCvMemStorage); cdecl;
  TcvClearND = procedure(arr: pCvArr; idx: pInteger); cdecl;
  TcvClearSeq = procedure(seq: pCvSeq); cdecl;
  TcvClearSet = procedure( set_header:pCvSet ); cdecl;
  TcvCmp = procedure(const src1, src2: pCvArr; dst: pCvArr; cmp_op: integer); cdecl;
  TcvCmpS = procedure(const src: pCvArr; value: double; dst: pCvArr; cmp_op: integer); cdecl;
  TcvCompleteSymm = procedure(matrix: pCvMat; LtoR: Integer = 0); cdecl;
  TcvConvertScale = procedure(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl;
  TcvConvertScaleAbs = procedure(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl;
  TcvCopy = procedure(const src: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl;
  TcvCopyImage = procedure(const src: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl;
  TcvCreateData = procedure(arr: pCvArr); cdecl;
  TcvCreateSeqBlock = procedure(writer: pCvSeqWriter); cdecl;
  TcvCrossProduct = procedure(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl;
  TcvCvtPixToPlane = procedure(const src: pCvArr; dst0: pCvArr; dst1: pCvArr; dst2: pCvArr; dst3: pCvArr); cdecl;
  TcvCvtPlaneToPix = procedure(const src0: pCvArr; const src1: pCvArr; const src2: pCvArr; const src3: pCvArr; dst: pCvArr); cdecl;
  TcvCvtScale = procedure(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl;
  TcvCvtScaleAbs = procedure; cdecl;
  TcvCvtSeqToArray = procedure(const seq: pCvSeq; elements: pCvArr; slice: TCvSlice  ); cdecl;
  TcvDCT = procedure(const src: pCvArr; dst: pCvArr; flags: Integer); cdecl;
  TcvDFT = procedure(const src: pCvArr; dst: pCvArr; flags: Integer; nonzero_rows: Integer = 0); cdecl;
  TcvDiv = procedure(const src1, src2: pIplImage; dst: pIplImage; scale: double = 1); cdecl;
  TcvDrawContours = procedure(img: pIplImage; contour: pCvSeq; external_color, hole_color: TCvScalar; max_level, thickness  , line_type: Integer ; offset: TCvPoint  ); cdecl;
  TcvEigenVV = procedure(mat: pCvArr; evects: pCvArr; evals: pCvArr; eps: double = 0; lowindex: Integer = -1; highindex: Integer = -1); cdecl;
  TcvEllipse = procedure(img: pCvArr; center: TCvPoint; axes: TCvSize; angle: double; start_angle: double; nd_angle: double; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl;
  TcvEndWriteStruct = procedure(fs:pCvFileStorage ); cdecl;
  TcvError = procedure(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar = nil; line: Integer = 0); cdecl;
  TcvExp = procedure(const src: pCvArr; dst: pCvArr); cdecl;
  TcvFFT = procedure(const src: pCvArr; dst: pCvArr; flags: Integer; nonzero_rows: Integer = 0); cdecl;
  TcvFillConvexPoly = procedure(img: pCvArr; const pts: pCVPoint; npts: Integer; color: TCvScalar; line_type: Integer = 8; shift: Integer = 0); cdecl;
  TcvFillPoly = procedure( img:pCvArr; pts:pCvPointArray; const npts:pInteger; contours:Integer; color:TCvScalar; line_type :Integer=8; shift :Integer=0 ); cdecl;
  TcvFlip = procedure(const src: pCvArr; dst: pCvArr = nil; flip_mode: Integer = 0); cdecl;
  TcvFlushSeqWriter = procedure( writer:pCvSeqWriter ); cdecl;
  TcvFree_ = procedure(ptr: Pointer); cdecl;
  TcvGEMM = procedure(const src1: pCvArr; const src2: pCvArr; alpha: double; const src3: pCvArr; beta: double; dst: pCvArr; tABC: Integer = 0); cdecl;
  TcvGetModuleInfo = procedure(const module_name: pCvChar; const version: ppCvChar; const loaded_addon_plugins: ppCvChar); cdecl;
  TcvGetRawData = procedure(arr: pCvArr; data: pByte; step: pInteger = nil; roi_size: pCvSize = nil); cdecl;
  TcvGetTextSize = procedure(const text_string: pCvChar; const font: pCvFont; text_size: pCvSize; var baseline: Integer); cdecl;
  TcvGraphRemoveEdge = procedure(graph: pCvGraph; start_idx: Integer; end_idx: Integer); cdecl;
  TcvGraphRemoveEdgeByPtr = procedure(graph: pCvGraph; start_vtx: pCvGraphVtx; end_vtx: pCvGraphVtx); cdecl;
  TcvInitFont = procedure(font: pCvFont; font_face: Integer; hscale: double; vscale: double; shear: double = 0; thickness: Integer = 1; line_type: Integer = 8); cdecl;
  TcvInitTreeNodeIterator = procedure(var tree_iterator: TCvTreeNodeIterator; const first: Pointer; max_level: Integer); cdecl;
  TcvInRange = procedure(const src: pIplImage; const lower: pIplImage; const upper: pIplImage; dst: pIplImage); cdecl;
  TcvInRangeS = procedure(const src: pIplImage; lower: TCvScalar; upper: TCvScalar; dst: pIplImage); cdecl;
  TcvInsertNodeIntoTree = procedure(node: Pointer; parent: Pointer; frame: Pointer); cdecl;
  TcvLine = procedure(img: pCvArr; pt1, pt2: TCvPoint; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl;
  TcvLog = procedure(const src: pCvArr; dst: pCvArr); cdecl;
  TcvLUT = procedure(const src: pCvArr; dst: pCvArr; const lut: pCvArr); cdecl;
  TcvMatMulAddEx = procedure(const src1: pCvArr; const src2: pCvArr; alpha: double; const src3: pCvArr; beta: double; dst: pCvArr; tABC: Integer = 0); cdecl;
  TcvMatMulAddS = procedure(const src: pCvArr; dst: pCvArr; const transmat: pCvMat; const shiftvec: pCvMat = nil); cdecl;
  TcvMax = procedure(const src1, src2:pCvArr; dst:pCvArr); cdecl;
  TcvMaxS = procedure(const src:pCvArr; value:double; dst:pCvArr); cdecl;
  TcvMerge = procedure(const src0: pIplImage; const src1: pIplImage; const src2: pIplImage; const src3: pIplImage; dst: pIplImage); cdecl;
  TcvMin = procedure(const src1, src2:pCvArr; dst:pCvArr); cdecl;
  TcvMinMaxLoc = procedure(const arr: pIplImage; min_val: pDouble; max_val: pDouble; min_loc: pCVPoint = nil; max_loc: pCVPoint = nil; const mask: pIplImage = nil); cdecl;
  TcvMinS = procedure(const src:pCvArr; value:double; dst:pCvArr); cdecl;
  TcvMirror = procedure(const src: pCvArr; dst: pCvArr = nil; flip_mode: Integer = 0); cdecl;
  TcvMixChannels = procedure(src: array of pCvArr; src_count: Integer; dst: array of pCvArr; dst_count: Integer; const from_to: pInteger; pair_count: Integer); cdecl;
  TcvMul = procedure(const src1, src2: pIplImage; dst: pIplImage; scale: double = 1); cdecl;
  TcvMulSpectrums = procedure(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; flags: Integer); cdecl;
  TcvMulTransposed = procedure(const src: pCvArr; dst: pCvArr; order: Integer; const delta: pCvArr = nil; scale: double = 1); cdecl;
  TcvNormalize = procedure(const src: pCvArr; dst: pCvArr; A: double ; B: double ; norm_type: Integer ; const mask: pCvArr = nil); cdecl;
  TcvNot = procedure(const src: pCvArr; dst: pCvArr); cdecl;
  TcvOr = procedure(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl;
  TcvOrS = procedure(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl;
  TcvPerspectiveTransform = procedure(const src: pCvArr; dst: pCvArr; const mat: pCvMat); cdecl;
  TcvPolarToCart = procedure(const magnitude: pCvArr; const angle: pCvArr; x: pCvArr; y: pCvArr; angle_in_degrees: Integer = 0); cdecl;
  TcvPolyLine = procedure(img: pCvArr; pts: pCVPoint; const npts: pInteger; contours: Integer; is_closed: Integer; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl;
  TcvPow = procedure(const src: pCvArr; dst: pCvArr; power: double); cdecl;
  TcvProjectPCA = procedure(const data: pCvArr; const mean: pCvArr; const eigenvects: pCvArr; result: pCvArr); cdecl;
  TcvPutText = procedure(img: pCvArr; const text: pCvChar; org: TCvPoint; const font: pCvFont; color: TCvScalar); cdecl;
  TcvRandArr = procedure(rng: pCvRNG; arr: pCvArr; dist_type: Integer; param1: TCvScalar; param2: TCvScalar); cdecl;
  TcvRandShuffle = procedure(mat: pCvArr; rng: pCvRNG; iter_factor: double = 1); cdecl;
  TcvRawDataToScalar = procedure(const data: pCvArr; cType: Integer; scalar: pCvScalar); cdecl;
  TcvReadRawData = procedure(const fs: pCvFileStorage; const src: pCvFileNode; dst: Pointer; const dt: pCvChar); cdecl;
  TcvReadRawDataSlice = procedure(const fs: pCvFileStorage; reader: pCvSeqReader; count: Integer; dst: Pointer; const dt: pCvChar); cdecl;
  TcvRectangle = procedure(img: pCvArr; pt1: TCvPoint; pt2: TCvPoint; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl;
  TcvRectangleR = procedure( img:pCvArr; r:TCvRect; color:TCvScalar; thickness:integer=1; line_type :integer =8; shift:integer=0); cdecl;
  TcvReduce = procedure(const src: pCvArr; dst: pCvArr; dim: Integer = -1; op: Integer = CV_REDUCE_SUM); cdecl;
  TcvRegisterType = procedure(const info: pCvTypeInfo); cdecl;
  TcvRelease = procedure(var struct_ptr: Pointer); cdecl;
  TcvReleaseData = procedure(arr: pCvArr); cdecl;
  TcvReleaseFileStorage = procedure(var fs: pCvFileStorage); cdecl;
  TcvReleaseGraphScanner = procedure(var scanner: pCvGraphScanner); cdecl;
  TcvReleaseImage = procedure(var image: pIplImage); cdecl;
  TcvReleaseImageHeader = procedure(var image: pIplImage); cdecl;
  TcvReleaseMat = procedure(var mat: pCvMat); cdecl;
  TcvReleaseMemStorage = procedure(var storage: pCvMemStorage); cdecl;
  TcvReleaseSparseMat = procedure(mat: pCvSparseMat); cdecl;
  TcvRemoveNodeFromTree = procedure(node: Pointer; frame: Pointer); cdecl;
  TcvRepeat = procedure(src, dst: pCvArr); cdecl;
  TcvResetImageROI = procedure(image: pIplImage); cdecl;
  TcvRestoreMemStoragePos = procedure(storage:pCvMemStorage; pos:pCvMemStoragePos); cdecl;
  TcvSave = procedure(const filename: pCvChar; const struct_ptr: Pointer; const name: pCvChar; const comment: pCvChar; attributes: TCvAttrList); cdecl;
  TcvSaveMemStoragePos = procedure(const storage:pCvMemStorage; pos:pCvMemStoragePos); cdecl;
  TcvScalarToRawData = procedure(const scalar: pCvScalar; data: pCvArr; cType: Integer; extend_to_12: Integer = 0); cdecl;
  TcvScale = procedure(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl;
  TcvScaleAdd = procedure(const src1: pIplImage; scale: TCvScalar; const src2: pIplImage; dst: pIplImage); cdecl;
  TcvSeqInsertSlice = procedure(seq:pCvSeq; before_index:integer; const from_arr:pCvArr); cdecl;
  TcvSeqInvert = procedure( seq:pCvSeq ); cdecl;
  TcvSeqPop = procedure(seq:pCvSeq; element : pointer = nil); cdecl;
  TcvSeqPopFront = procedure(seq:pCvSeq; element :pointer = nil); cdecl;
  TcvSeqPopMulti = procedure(seq:pCvSeq; elements:pointer; count:integer; in_front:integer=0); cdecl;
  TcvSeqPushMulti = procedure(seq:pCvSeq; const elements:pointer; count:Integer; in_front:integer = 0); cdecl;
  TcvSeqRemove = procedure(seq: pCvSeq; index: Integer); cdecl;
  TcvSeqRemoveSlice = procedure( seq:pCvSeq; slice :TCvSlice); cdecl;
  TcvSeqSort = procedure(seq:pCvSeq; func:TCvCmpFunc; userdata:pointer = nil); cdecl;
  TcvSet = procedure(arr: pCvArr; value: TCvScalar; const mask: pCvArr = nil); cdecl;
  TcvSet1D = procedure(arr: pCvArr; idx0: Integer; value: TCvScalar); cdecl;
  TcvSet2D = procedure(arr: pCvArr; idx0, idx1: Integer; value: TCvScalar); cdecl;
  TcvSet3D = procedure(arr: pCvArr; idx0, idx1, idx2: Integer; value: TCvScalar); cdecl;
  TcvSetData = procedure(arr: pCvArr; data: Pointer; step: Integer); cdecl;
  TcvSetErrStatus = procedure(status: Integer); cdecl;
  TcvSetIdentity = procedure(mat: pCvArr; value: TCvScalar  ); cdecl;
  TcvSetImageCOI = procedure(image: pIplImage; coi: Integer); cdecl;
  TcvSetImageROI = procedure(image: pIplImage; rect: TCvRect); cdecl;
  TcvSetIPLAllocators = procedure(create_header: TCv_iplCreateImageHeader; allocate_data: TCv_iplAllocateImageData; deallocate: TCv_iplDeallocate; create_roi: TCv_iplCreateROI; clone_image: TCv_iplCloneImage); cdecl;
  TcvSetMemoryManager = procedure(alloc_func: TCvAllocFunc = nil; free_func: TCvFreeFunc = nil; userdata: Pointer = nil); cdecl;
  TcvSetND = procedure(arr: pCvArr; idx: pInteger; value: TCvScalar); cdecl;
  TcvSetNumThreads = procedure(threads: Integer = 0); cdecl;
  TcvSetReal1D = procedure(arr: pCvArr; idx0: Integer; value: double); cdecl;
  TcvSetReal2D = procedure(arr: pCvArr; idx0, idx1: Integer; value: double); cdecl;
  TcvSetReal3D = procedure(arr: pCvArr; idx0, idx1, idx2: Integer; value: double); cdecl;
  TcvSetRealND = procedure(arr: pCvArr; idx: pInteger; value: double); cdecl;
  TcvSetRemove = procedure(set_header:pCvSet; index:Integer ); cdecl;
  TcvSetSeqBlockSize = procedure( seq:pCvSeq; delta_elems:Integer ); cdecl;
  TcvSetSeqReaderPos = procedure(reader:pCvSeqReader; index:Integer; is_relative :Integer = 0); cdecl;
  TcvSetZero = procedure(arr: pCvArr); cdecl;
  TcvSolvePoly = procedure(const coeffs: pCvMat; roots2: pCvMat; maxiter: Integer = 20; fig: Integer = 100); cdecl;
  TcvSort = procedure(const src:pCvArr; dst : pCvArr = nil; idxmat :pCvArr=nil; flags : integer =0); cdecl;
  TcvSplit = procedure(const src: pCvArr; dst0: pCvArr; dst1: pCvArr; dst2: pCvArr = nil; dst3: pCvArr = nil); cdecl;
  TcvStartAppendToSeq = procedure(seq:pCvSeq; writer:pCvSeqWriter); cdecl;
  TcvStartNextStream = procedure(fs: pCvFileStorage); cdecl;
  TcvStartReadRawData = procedure(const fs: pCvFileStorage; const src: pCvFileNode; reader: pCvSeqReader); cdecl;
  TcvStartReadSeq = procedure(const seq: Pointer; reader: pCvSeqReader; reverse: Integer = 0); cdecl;
  TcvStartWriteSeq = procedure( seq_flags:integer; header_size:Integer; elem_size:Integer; storage:pCvMemStorage; writer:pCvSeqWriter); cdecl;
  TcvStartWriteStruct = procedure( fs:pCvFileStorage; const name:pCVChar; struct_flags:Integer; const type_name :pCVChar; attributes:TCvAttrList); cdecl;
  TcvSub = procedure(const src1, src2: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl;
  TcvSubRS = procedure(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil); cdecl;
  TcvSVBkSb = procedure(const W: pCvArr; const U: pCvArr; const V: pCvArr; const B: pCvArr; x: pCvArr; flags: Integer); cdecl;
  TcvSVD = procedure(A: pCvArr; W: pCvArr; U: pCvArr = nil; V: pCvArr = nil; flags: Integer = 0); cdecl;
  TcvT = procedure(const src: pCvArr; dst: pCvArr); cdecl;
  TcvTransform = procedure(const src: pCvArr; dst: pCvArr; const transmat: pCvMat; const shiftvec: pCvMat = nil); cdecl;
  TcvTranspose = procedure(const src: pCvArr; dst: pCvArr); cdecl;
  TcvUnregisterType = procedure(const type_name: pCvChar); cdecl;
  TcvWrite = procedure(fs: pCvFileStorage; const name: pCvChar; const ptr: pCvArr; attributes: TCvAttrList  ); cdecl;
  TcvWriteComment = procedure(fs: pCvFileStorage; const comment: pCvChar; eol_comment: Integer); cdecl;
  TcvWriteFileNode = procedure(fs: pCvFileStorage; const new_node_name: pCvChar; const node: pCvFileNode; embed: Integer); cdecl;
  TcvWriteInt = procedure(fs: pCvFileStorage; const name: pCvChar; value: Integer); cdecl;
  TcvWriteRawData = procedure(fs: pCvFileStorage; const src: Pointer; len: Integer; const dt: pCvChar); cdecl;
  TcvWriteReal = procedure(fs: pCvFileStorage; const name: pCvChar; value: double); cdecl;
  TcvWriteString = procedure(fs: pCvFileStorage; const name: pCvChar; const str: pCvChar; quote: Integer = 0); cdecl;
  TcvXor = procedure(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl;
  TcvXorS = procedure(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pCvArr = nil); cdecl;
  TcvZero = procedure(arr: pCvArr); cdecl;

var
  cvAlloc: TcvAlloc;
  cvAttrValue: TcvAttrValue;
  cvAvg: TcvAvg;
  cvCbrt: TcvCbrt;
  cvCheckArr: TcvCheckArr;
  cvCheckHardwareSupport: TcvCheckHardwareSupport;
  cvCheckTermCriteria: TcvCheckTermCriteria;
  cvClipLine: TcvClipLine;
  cvClone: TcvClone;
  cvCloneGraph: TcvCloneGraph;
  cvCloneImage: TcvCloneImage;
  cvCloneMat: TcvCloneMat;
  cvCloneMatND: TcvCloneMatND;
  cvCloneSparseMat: TcvCloneSparseMat;
  cvColorToScalar: TcvColorToScalar;
  cvCountNonZero: TcvCountNonZero;
  cvCreateChildMemStorage: TcvCreateChildMemStorage;
  cvCreateGraph: TcvCreateGraph;
  cvCreateGraphScanner: TcvCreateGraphScanner;
  cvCreateImage: TcvCreateImage;
  cvCreateImageHeader: TcvCreateImageHeader;
  cvCreateMat: TcvCreateMat;
  cvCreateMatHeader: TcvCreateMatHeader;
  cvCreateMatND: TcvCreateMatND;
  cvCreateMatNDHeader: TcvCreateMatNDHeader;
  cvCreateMemStorage: TcvCreateMemStorage;
  cvCreateSeq: TcvCreateSeq;
  cvCreateSet: TcvCreateSet;
  cvCreateSparseMat: TcvCreateSparseMat;
  cvDet: TcvDet;
  cvDotProduct: TcvDotProduct;
  cvEllipse2Poly: TcvEllipse2Poly;
  cvEndWriteSeq: TcvEndWriteSeq;
  cvErrorFromIppStatus: TcvErrorFromIppStatus;
  cvErrorStr: TcvErrorStr;
  cvFastArctan: TcvFastArctan;
  cvFindGraphEdge: TcvFindGraphEdge;
  cvFindGraphEdgeByPtr: TcvFindGraphEdgeByPtr;
  cvFindType: TcvFindType;
  cvFirstType: TcvFirstType;
  cvGet1D: TcvGet1D;
  cvGet2D: TcvGet2D;
  cvGet3D: TcvGet3D;
  cvGetCols: TcvGetCols;
  cvGetDiag: TcvGetDiag;
  cvGetDims: TcvGetDims;
  cvGetDimSize: TcvGetDimSize;
  cvGetElemType: TcvGetElemType;
  cvGetErrInfo: TcvGetErrInfo;
  cvGetErrMode: TcvGetErrMode;
  cvGetErrStatus: TcvGetErrStatus;
  cvGetFileNode: TcvGetFileNode;
  cvGetFileNodeByName: TcvGetFileNodeByName;
  cvGetFileNodeName: TcvGetFileNodeName;
  cvGetHashedKey: TcvGetHashedKey;
  cvGetImage: TcvGetImage;
  cvGetImageCOI: TcvGetImageCOI;
  cvGetImageROI: TcvGetImageROI;
  cvGetMat: TcvGetMat;
  cvGetND: TcvGetND;
  cvGetNumThreads: TcvGetNumThreads;
  cvGetOptimalDFTSize: TcvGetOptimalDFTSize;
  cvGetReal1D: TcvGetReal1D;
  cvGetReal2D: TcvGetReal2D;
  cvGetReal3D: TcvGetReal3D;
  cvGetRealND: TcvGetRealND;
  cvGetRootFileNode: TcvGetRootFileNode;
  cvGetRows: TcvGetRows;
  cvGetSeqElem: TcvGetSeqElem;
  cvGetSeqReaderPos: TcvGetSeqReaderPos;
  cvGetSize: TcvGetSize;
  cvGetSubArr: TcvGetSubArr;
  cvGetSubRect: TcvGetSubRect;
  cvGetThreadNum: TcvGetThreadNum;
  cvGetTickCount: TcvGetTickCount;
  cvGetTickFrequency: TcvGetTickFrequency;
  cvGraphAddEdge: TcvGraphAddEdge;
  cvGraphAddEdgeByPtr: TcvGraphAddEdgeByPtr;
  cvGraphAddVtx: TcvGraphAddVtx;
  cvGraphRemoveVtx: TcvGraphRemoveVtx;
  cvGraphRemoveVtxByPtr: TcvGraphRemoveVtxByPtr;
  cvGraphVtxDegree: TcvGraphVtxDegree;
  cvGraphVtxDegreeByPtr: TcvGraphVtxDegreeByPtr;
  cvGuiBoxReport: TcvGuiBoxReport;
  cvInitImageHeader: TcvInitImageHeader;
  cvInitLineIterator: TcvInitLineIterator;
  cvInitMatHeader: TcvInitMatHeader;
  cvInitMatNDHeader: TcvInitMatNDHeader;
  cvInitNArrayIterator: TcvInitNArrayIterator;
  cvInitSparseMatIterator: TcvInitSparseMatIterator;
  cvInvert: TcvInvert;
  cvKMeans2: TcvKMeans2;
  cvLoad: TcvLoad;
  cvMahalanobis: TcvMahalanobis;
  cvMakeSeqHeaderForArray: TcvMakeSeqHeaderForArray;
  cvMemStorageAlloc: TcvMemStorageAlloc;
  cvMemStorageAllocString: TcvMemStorageAllocString;
  cvNextGraphItem: TcvNextGraphItem;
  cvNextNArraySlice: TcvNextNArraySlice;
  cvNextTreeNode: TcvNextTreeNode;
  cvNorm: TcvNorm;
  cvNulDevReport: TcvNulDevReport;
  cvOpenFileStorage: TcvOpenFileStorage;
  cvPrevTreeNode: TcvPrevTreeNode;
  cvPtr1D: TcvPtr1D;
  cvPtr2D: TcvPtr2D;
  cvPtr3D: TcvPtr3D;
  cvPtrND: TcvPtrND;
  cvRange: TcvRange;
  cvRead: TcvRead;
  cvRedirectError: TcvRedirectError;
  cvRegisterModule: TcvRegisterModule;
  cvReshape: TcvReshape;
  cvReshapeMatND: TcvReshapeMatND;
  cvSeqElemIdx: TcvSeqElemIdx;
  cvSeqInsert: TcvSeqInsert;
  cvSeqPartition: TcvSeqPartition;
  cvSeqPush: TcvSeqPush;
  cvSeqPushFront: TcvSeqPushFront;
  cvSeqSearch: TcvSeqSearch;
  cvSeqSlice: TcvSeqSlice;
  cvSetAdd: TcvSetAdd;
  cvSetErrMode: TcvSetErrMode;
  cvSliceLength: TcvSliceLength;
  cvSolve: TcvSolve;
  cvSolveCubic: TcvSolveCubic;
  cvStdErrReport: TcvStdErrReport;
  cvSum: TcvSum;
  cvTrace: TcvTrace;
  cvTreeToNodeSeq: TcvTreeToNodeSeq;
  cvTypeOf: TcvTypeOf;
  cvUseOptimized: TcvUseOptimized;
  cvAbsDiff: TcvAbsDiff;
  cvAbsDiffS: TcvAbsDiffS;
  cvAdd: TcvAdd;
  cvAddS: TcvAddS;
  cvAddWeighted: TcvAddWeighted;
  cvAnd: TcvAnd;
  cvAndS: TcvAndS;
  cvAvgSdv: TcvAvgSdv;
  cvBackProjectPCA: TcvBackProjectPCA;
  cvCalcCovarMatrix: TcvCalcCovarMatrix;
  cvCalcPCA: TcvCalcPCA;
  cvCartToPolar: TcvCartToPolar;
  cvChangeSeqBlock: TcvChangeSeqBlock;
  cvCircle: TcvCircle;
  cvClearGraph: TcvClearGraph;
  cvClearMemStorage: TcvClearMemStorage;
  cvClearND: TcvClearND;
  cvClearSeq: TcvClearSeq;
  cvClearSet: TcvClearSet;
  cvCmp: TcvCmp;
  cvCmpS: TcvCmpS;
  cvCompleteSymm: TcvCompleteSymm;
  cvConvertScale: TcvConvertScale;
  cvConvertScaleAbs: TcvConvertScaleAbs;
  cvCopy: TcvCopy;
  cvCopyImage: TcvCopyImage;
  cvCreateData: TcvCreateData;
  cvCreateSeqBlock: TcvCreateSeqBlock;
  cvCrossProduct: TcvCrossProduct;
  cvCvtPixToPlane: TcvCvtPixToPlane;
  cvCvtPlaneToPix: TcvCvtPlaneToPix;
  cvCvtScale: TcvCvtScale;
  cvCvtScaleAbs: TcvCvtScaleAbs;
  cvCvtSeqToArray: TcvCvtSeqToArray;
  cvDCT: TcvDCT;
  cvDFT: TcvDFT;
  cvDiv: TcvDiv;
  cvDrawContours: TcvDrawContours;
  cvEigenVV: TcvEigenVV;
  cvEllipse: TcvEllipse;
  cvEndWriteStruct: TcvEndWriteStruct;
  cvError: TcvError;
  cvExp: TcvExp;
  cvFFT: TcvFFT;
  cvFillConvexPoly: TcvFillConvexPoly;
  cvFillPoly: TcvFillPoly;
  cvFlip: TcvFlip;
  cvFlushSeqWriter: TcvFlushSeqWriter;
  cvFree_: TcvFree_;
  cvGEMM: TcvGEMM;
  cvGetModuleInfo: TcvGetModuleInfo;
  cvGetRawData: TcvGetRawData;
  cvGetTextSize: TcvGetTextSize;
  cvGraphRemoveEdge: TcvGraphRemoveEdge;
  cvGraphRemoveEdgeByPtr: TcvGraphRemoveEdgeByPtr;
  cvInitFont: TcvInitFont;
  cvInitTreeNodeIterator: TcvInitTreeNodeIterator;
  cvInRange: TcvInRange;
  cvInRangeS: TcvInRangeS;
  cvInsertNodeIntoTree: TcvInsertNodeIntoTree;
  cvLine: TcvLine;
  cvLog: TcvLog;
  cvLUT: TcvLUT;
  cvMatMulAddEx: TcvMatMulAddEx;
  cvMatMulAddS: TcvMatMulAddS;
  cvMax: TcvMax;
  cvMaxS: TcvMaxS;
  cvMerge: TcvMerge;
  cvMin: TcvMin;
  cvMinMaxLoc: TcvMinMaxLoc;
  cvMinS: TcvMinS;
  cvMirror: TcvMirror;
  cvMixChannels: TcvMixChannels;
  cvMul: TcvMul;
  cvMulSpectrums: TcvMulSpectrums;
  cvMulTransposed: TcvMulTransposed;
  cvNormalize: TcvNormalize;
  cvNot: TcvNot;
  cvOr: TcvOr;
  cvOrS: TcvOrS;
  cvPerspectiveTransform: TcvPerspectiveTransform;
  cvPolarToCart: TcvPolarToCart;
  cvPolyLine: TcvPolyLine;
  cvPow: TcvPow;
  cvProjectPCA: TcvProjectPCA;
  cvPutText: TcvPutText;
  cvRandArr: TcvRandArr;
  cvRandShuffle: TcvRandShuffle;
  cvRawDataToScalar: TcvRawDataToScalar;
  cvReadRawData: TcvReadRawData;
  cvReadRawDataSlice: TcvReadRawDataSlice;
  cvRectangle: TcvRectangle;
  cvRectangleR: TcvRectangleR;
  cvReduce: TcvReduce;
  cvRegisterType: TcvRegisterType;
  cvRelease: TcvRelease;
  cvReleaseData: TcvReleaseData;
  cvReleaseFileStorage: TcvReleaseFileStorage;
  cvReleaseGraphScanner: TcvReleaseGraphScanner;
  cvReleaseImage: TcvReleaseImage;
  cvReleaseImageHeader: TcvReleaseImageHeader;
  cvReleaseMat: TcvReleaseMat;
  cvReleaseMemStorage: TcvReleaseMemStorage;
  cvReleaseSparseMat: TcvReleaseSparseMat;
  cvRemoveNodeFromTree: TcvRemoveNodeFromTree;
  cvRepeat: TcvRepeat;
  cvResetImageROI: TcvResetImageROI;
  cvRestoreMemStoragePos: TcvRestoreMemStoragePos;
  cvSave: TcvSave;
  cvSaveMemStoragePos: TcvSaveMemStoragePos;
  cvScalarToRawData: TcvScalarToRawData;
  cvScale: TcvScale;
  cvScaleAdd: TcvScaleAdd;
  cvSeqInsertSlice: TcvSeqInsertSlice;
  cvSeqInvert: TcvSeqInvert;
  cvSeqPop: TcvSeqPop;
  cvSeqPopFront: TcvSeqPopFront;
  cvSeqPopMulti: TcvSeqPopMulti;
  cvSeqPushMulti: TcvSeqPushMulti;
  cvSeqRemove: TcvSeqRemove;
  cvSeqRemoveSlice: TcvSeqRemoveSlice;
  cvSeqSort: TcvSeqSort;
  cvSet: TcvSet;
  cvSet1D: TcvSet1D;
  cvSet2D: TcvSet2D;
  cvSet3D: TcvSet3D;
  cvSetData: TcvSetData;
  cvSetErrStatus: TcvSetErrStatus;
  cvSetIdentity: TcvSetIdentity;
  cvSetImageCOI: TcvSetImageCOI;
  cvSetImageROI: TcvSetImageROI;
  cvSetIPLAllocators: TcvSetIPLAllocators;
  cvSetMemoryManager: TcvSetMemoryManager;
  cvSetND: TcvSetND;
  cvSetNumThreads: TcvSetNumThreads;
  cvSetReal1D: TcvSetReal1D;
  cvSetReal2D: TcvSetReal2D;
  cvSetReal3D: TcvSetReal3D;
  cvSetRealND: TcvSetRealND;
  cvSetRemove: TcvSetRemove;
  cvSetSeqBlockSize: TcvSetSeqBlockSize;
  cvSetSeqReaderPos: TcvSetSeqReaderPos;
  cvSetZero: TcvSetZero;
  cvSolvePoly: TcvSolvePoly;
  cvSort: TcvSort;
  cvSplit: TcvSplit;
  cvStartAppendToSeq: TcvStartAppendToSeq;
  cvStartNextStream: TcvStartNextStream;
  cvStartReadRawData: TcvStartReadRawData;
  cvStartReadSeq: TcvStartReadSeq;
  cvStartWriteSeq: TcvStartWriteSeq;
  cvStartWriteStruct: TcvStartWriteStruct;
  cvSub: TcvSub;
  cvSubRS: TcvSubRS;
  cvSVBkSb: TcvSVBkSb;
  cvSVD: TcvSVD;
  cvT: TcvT;
  cvTransform: TcvTransform;
  cvTranspose: TcvTranspose;
  cvUnregisterType: TcvUnregisterType;
  cvWrite: TcvWrite;
  cvWriteComment: TcvWriteComment;
  cvWriteFileNode: TcvWriteFileNode;
  cvWriteInt: TcvWriteInt;
  cvWriteRawData: TcvWriteRawData;
  cvWriteReal: TcvWriteReal;
  cvWriteString: TcvWriteString;
  cvXor: TcvXor;
  cvXorS: TcvXorS;
  cvZero: TcvZero;

function GetProcAddress(const Handle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND}; const ProcName: string; const RaiseError: Boolean): Pointer;
procedure Initialize(const Handle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND}; const RaiseError: Boolean);

const
  CoreLibName = core_lib;
var
  CoreLibHandle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND};

implementation

uses
  {$IFDEF FPC}
  Windows, {$IFDEF UNIX}dynlibs, {$ENDIF}SysUtils, VersionUtils;
  {$ELSE}
  Winapi.Windows, System.SysUtils, VersionUtils;
  {$ENDIF}

function GetProcAddress(const Handle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND}; const ProcName: string; const RaiseError: Boolean): Pointer;
var
  S: string;
  Version: TVersion;
begin
  Result := {$IF Defined(FPC) AND Defined(UNIX)}dynlibs{$ELSE}{$IF NOT Defined(FPC)}Winapi.{$ENDIF}Windows{$ENDIF}.GetProcAddress(Handle, PChar(ProcName));
  if not Assigned(Result) and RaiseError then
  begin
    {$IF Defined(FPC) AND Defined(UNIX))}
    S := GetModuleFileName(Pointer(Handle));
    {$ELSE}
    SetLength(S, MAX_PATH + 1);
    SetLength(S, GetModuleFileName(Handle, PChar(S), MAX_PATH + 1));
    {$ENDIF}
    Version := GetFileVersion(S);
    raise Exception.CreateFmt('Error while loading %d.%d function: %s', [Version.H, Version.L, ProcName]);
  end;
end;

procedure Initialize(const Handle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND}; const RaiseError: Boolean);
begin
  cvAlloc := GetProcAddress(Handle, 'cvAlloc', RaiseError);
  cvAttrValue := GetProcAddress(Handle, 'cvAttrValue', RaiseError);
  cvAvg := GetProcAddress(Handle, 'cvAvg', RaiseError);
  cvCbrt := GetProcAddress(Handle, 'cvCbrt', RaiseError);
  cvCheckArr := GetProcAddress(Handle, 'cvCheckArr', RaiseError);
  cvCheckHardwareSupport := GetProcAddress(Handle, 'cvCheckHardwareSupport', RaiseError);
  cvCheckTermCriteria := GetProcAddress(Handle, 'cvCheckTermCriteria', RaiseError);
  cvClipLine := GetProcAddress(Handle, 'cvClipLine', RaiseError);
  cvClone := GetProcAddress(Handle, 'cvClone', RaiseError);
  cvCloneGraph := GetProcAddress(Handle, 'cvCloneGraph', RaiseError);
  cvCloneImage := GetProcAddress(Handle, 'cvCloneImage', RaiseError);
  cvCloneMat := GetProcAddress(Handle, 'cvCloneMat', RaiseError);
  cvCloneMatND := GetProcAddress(Handle, 'cvCloneMatND', RaiseError);
  cvCloneSparseMat := GetProcAddress(Handle, 'cvCloneSparseMat', RaiseError);
  cvColorToScalar := GetProcAddress(Handle, 'cvColorToScalar', RaiseError);
  cvCountNonZero := GetProcAddress(Handle, 'cvCountNonZero', RaiseError);
  cvCreateChildMemStorage := GetProcAddress(Handle, 'cvCreateChildMemStorage', RaiseError);
  cvCreateGraph := GetProcAddress(Handle, 'cvCreateGraph', RaiseError);
  cvCreateGraphScanner := GetProcAddress(Handle, 'cvCreateGraphScanner', RaiseError);
  cvCreateImage := GetProcAddress(Handle, 'cvCreateImage', RaiseError);
  cvCreateImageHeader := GetProcAddress(Handle, 'cvCreateImageHeader', RaiseError);
  cvCreateMat := GetProcAddress(Handle, 'cvCreateMat', RaiseError);
  cvCreateMatHeader := GetProcAddress(Handle, 'cvCreateMatHeader', RaiseError);
  cvCreateMatND := GetProcAddress(Handle, 'cvCreateMatND', RaiseError);
  cvCreateMatNDHeader := GetProcAddress(Handle, 'cvCreateMatNDHeader', RaiseError);
  cvCreateMemStorage := GetProcAddress(Handle, 'cvCreateMemStorage', RaiseError);
  cvCreateSeq := GetProcAddress(Handle, 'cvCreateSeq', RaiseError);
  cvCreateSet := GetProcAddress(Handle, 'cvCreateSet', RaiseError);
  cvCreateSparseMat := GetProcAddress(Handle, 'cvCreateSparseMat', RaiseError);
  cvDet := GetProcAddress(Handle, 'cvDet', RaiseError);
  cvDotProduct := GetProcAddress(Handle, 'cvDotProduct', RaiseError);
  cvEllipse2Poly := GetProcAddress(Handle, 'cvEllipse2Poly', RaiseError);
  cvEndWriteSeq := GetProcAddress(Handle, 'cvEndWriteSeq', RaiseError);
  cvErrorFromIppStatus := GetProcAddress(Handle, 'cvErrorFromIppStatus', RaiseError);
  cvErrorStr := GetProcAddress(Handle, 'cvErrorStr', RaiseError);
  cvFastArctan := GetProcAddress(Handle, 'cvFastArctan', RaiseError);
  cvFindGraphEdge := GetProcAddress(Handle, 'cvFindGraphEdge', RaiseError);
  cvFindGraphEdgeByPtr := GetProcAddress(Handle, 'cvFindGraphEdgeByPtr', RaiseError);
  cvFindType := GetProcAddress(Handle, 'cvFindType', RaiseError);
  cvFirstType := GetProcAddress(Handle, 'cvFirstType', RaiseError);
  cvGet1D := GetProcAddress(Handle, 'cvGet1D', RaiseError);
  cvGet2D := GetProcAddress(Handle, 'cvGet2D', RaiseError);
  cvGet3D := GetProcAddress(Handle, 'cvGet3D', RaiseError);
  cvGetCols := GetProcAddress(Handle, 'cvGetCols', RaiseError);
  cvGetDiag := GetProcAddress(Handle, 'cvGetDiag', RaiseError);
  cvGetDims := GetProcAddress(Handle, 'cvGetDims', RaiseError);
  cvGetDimSize := GetProcAddress(Handle, 'cvGetDimSize', RaiseError);
  cvGetElemType := GetProcAddress(Handle, 'cvGetElemType', RaiseError);
  cvGetErrInfo := GetProcAddress(Handle, 'cvGetErrInfo', RaiseError);
  cvGetErrMode := GetProcAddress(Handle, 'cvGetErrMode', RaiseError);
  cvGetErrStatus := GetProcAddress(Handle, 'cvGetErrStatus', RaiseError);
  cvGetFileNode := GetProcAddress(Handle, 'cvGetFileNode', RaiseError);
  cvGetFileNodeByName := GetProcAddress(Handle, 'cvGetFileNodeByName', RaiseError);
  cvGetFileNodeName := GetProcAddress(Handle, 'cvGetFileNodeName', RaiseError);
  cvGetHashedKey := GetProcAddress(Handle, 'cvGetHashedKey', RaiseError);
  cvGetImage := GetProcAddress(Handle, 'cvGetImage', RaiseError);
  cvGetImageCOI := GetProcAddress(Handle, 'cvGetImageCOI', RaiseError);
  cvGetImageROI := GetProcAddress(Handle, 'cvGetImageROI', RaiseError);
  cvGetMat := GetProcAddress(Handle, 'cvGetMat', RaiseError);
  cvGetND := GetProcAddress(Handle, 'cvGetND', RaiseError);
  cvGetNumThreads := GetProcAddress(Handle, 'cvGetNumThreads', RaiseError);
  cvGetOptimalDFTSize := GetProcAddress(Handle, 'cvGetOptimalDFTSize', RaiseError);
  cvGetReal1D := GetProcAddress(Handle, 'cvGetReal1D', RaiseError);
  cvGetReal2D := GetProcAddress(Handle, 'cvGetReal2D', RaiseError);
  cvGetReal3D := GetProcAddress(Handle, 'cvGetReal3D', RaiseError);
  cvGetRealND := GetProcAddress(Handle, 'cvGetRealND', RaiseError);
  cvGetRootFileNode := GetProcAddress(Handle, 'cvGetRootFileNode', RaiseError);
  cvGetRows := GetProcAddress(Handle, 'cvGetRows', RaiseError);
  cvGetSeqElem := GetProcAddress(Handle, 'cvGetSeqElem', RaiseError);
  cvGetSeqReaderPos := GetProcAddress(Handle, 'cvGetSeqReaderPos', RaiseError);
  cvGetSize := GetProcAddress(Handle, 'cvGetSize', RaiseError);
  cvGetSubArr := GetProcAddress(Handle, 'cvGetSubRect', RaiseError);
  cvGetSubRect := GetProcAddress(Handle, 'cvGetSubRect', RaiseError);
  cvGetThreadNum := GetProcAddress(Handle, 'cvGetThreadNum', RaiseError);
  cvGetTickCount := GetProcAddress(Handle, 'cvGetTickCount', RaiseError);
  cvGetTickFrequency := GetProcAddress(Handle, 'cvGetTickFrequency', RaiseError);
  cvGraphAddEdge := GetProcAddress(Handle, 'cvGraphAddEdge', RaiseError);
  cvGraphAddEdgeByPtr := GetProcAddress(Handle, 'cvGraphAddEdgeByPtr', RaiseError);
  cvGraphAddVtx := GetProcAddress(Handle, 'cvGraphAddVtx', RaiseError);
  cvGraphRemoveVtx := GetProcAddress(Handle, 'cvGraphRemoveVtx', RaiseError);
  cvGraphRemoveVtxByPtr := GetProcAddress(Handle, 'cvGraphRemoveVtxByPtr', RaiseError);
  cvGraphVtxDegree := GetProcAddress(Handle, 'cvGraphVtxDegree', RaiseError);
  cvGraphVtxDegreeByPtr := GetProcAddress(Handle, 'cvGraphVtxDegreeByPtr', RaiseError);
  cvGuiBoxReport := GetProcAddress(Handle, 'cvGuiBoxReport', RaiseError);
  cvInitImageHeader := GetProcAddress(Handle, 'cvInitImageHeader', RaiseError);
  cvInitLineIterator := GetProcAddress(Handle, 'cvInitLineIterator', RaiseError);
  cvInitMatHeader := GetProcAddress(Handle, 'cvInitMatHeader', RaiseError);
  cvInitMatNDHeader := GetProcAddress(Handle, 'cvInitMatNDHeader', RaiseError);
  cvInitNArrayIterator := GetProcAddress(Handle, 'cvInitNArrayIterator', RaiseError);
  cvInitSparseMatIterator := GetProcAddress(Handle, 'cvInitSparseMatIterator', RaiseError);
  cvInvert := GetProcAddress(Handle, 'cvInvert', RaiseError);
  cvKMeans2 := GetProcAddress(Handle, 'cvKMeans2', RaiseError);
  cvLoad := GetProcAddress(Handle, 'cvLoad', RaiseError);
  cvMahalanobis := GetProcAddress(Handle, 'cvMahalanobis', RaiseError);
  cvMakeSeqHeaderForArray := GetProcAddress(Handle, 'cvMakeSeqHeaderForArray', RaiseError);
  cvMemStorageAlloc := GetProcAddress(Handle, 'cvMemStorageAlloc', RaiseError);
  cvMemStorageAllocString := GetProcAddress(Handle, 'cvMemStorageAllocString', RaiseError);
  cvNextGraphItem := GetProcAddress(Handle, 'cvNextGraphItem', RaiseError);
  cvNextNArraySlice := GetProcAddress(Handle, 'cvNextNArraySlice', RaiseError);
  cvNextTreeNode := GetProcAddress(Handle, 'cvNextTreeNode', RaiseError);
  cvNorm := GetProcAddress(Handle, 'cvNorm', RaiseError);
  cvNulDevReport := GetProcAddress(Handle, 'cvNulDevReport', RaiseError);
  cvOpenFileStorage := GetProcAddress(Handle, 'cvOpenFileStorage', RaiseError);
  cvPrevTreeNode := GetProcAddress(Handle, 'cvPrevTreeNode', RaiseError);
  cvPtr1D := GetProcAddress(Handle, 'cvPtr1D', RaiseError);
  cvPtr2D := GetProcAddress(Handle, 'cvPtr2D', RaiseError);
  cvPtr3D := GetProcAddress(Handle, 'cvPtr3D', RaiseError);
  cvPtrND := GetProcAddress(Handle, 'cvPtrND', RaiseError);
  cvRange := GetProcAddress(Handle, 'cvRange', RaiseError);
  cvRead := GetProcAddress(Handle, 'cvRead', RaiseError);
  cvRedirectError := GetProcAddress(Handle, 'cvRedirectError', RaiseError);
  cvRegisterModule := GetProcAddress(Handle, 'cvRegisterModule', RaiseError);
  cvReshape := GetProcAddress(Handle, 'cvReshape', RaiseError);
  cvReshapeMatND := GetProcAddress(Handle, 'cvReshapeMatND', RaiseError);
  cvSeqElemIdx := GetProcAddress(Handle, 'cvSeqElemIdx', RaiseError);
  cvSeqInsert := GetProcAddress(Handle, 'cvSeqInsert', RaiseError);
  cvSeqPartition := GetProcAddress(Handle, 'cvSeqPartition', RaiseError);
  cvSeqPush := GetProcAddress(Handle, 'cvSeqPush', RaiseError);
  cvSeqPushFront := GetProcAddress(Handle, 'cvSeqPushFront', RaiseError);
  cvSeqSearch := GetProcAddress(Handle, 'cvSeqSearch', RaiseError);
  cvSeqSlice := GetProcAddress(Handle, 'cvSeqSlice', RaiseError);
  cvSetAdd := GetProcAddress(Handle, 'cvSetAdd', RaiseError);
  cvSetErrMode := GetProcAddress(Handle, 'cvSetErrMode', RaiseError);
  cvSliceLength := GetProcAddress(Handle, 'cvSliceLength', RaiseError);
  cvSolve := GetProcAddress(Handle, 'cvSolve', RaiseError);
  cvSolveCubic := GetProcAddress(Handle, 'cvSolveCubic', RaiseError);
  cvStdErrReport := GetProcAddress(Handle, 'cvStdErrReport', RaiseError);
  cvSum := GetProcAddress(Handle, 'cvSum', RaiseError);
  cvTrace := GetProcAddress(Handle, 'cvTrace', RaiseError);
  cvTreeToNodeSeq := GetProcAddress(Handle, 'cvTreeToNodeSeq', RaiseError);
  cvTypeOf := GetProcAddress(Handle, 'cvTypeOf', RaiseError);
  cvUseOptimized := GetProcAddress(Handle, 'cvUseOptimized', RaiseError);
  cvAbsDiff := GetProcAddress(Handle, 'cvAbsDiff', RaiseError);
  cvAbsDiffS := GetProcAddress(Handle, 'cvAbsDiffS', RaiseError);
  cvAdd := GetProcAddress(Handle, 'cvAdd', RaiseError);
  cvAddS := GetProcAddress(Handle, 'cvAddS', RaiseError);
  cvAddWeighted := GetProcAddress(Handle, 'cvAddWeighted', RaiseError);
  cvAnd := GetProcAddress(Handle, 'cvAnd', RaiseError);
  cvAndS := GetProcAddress(Handle, 'cvAndS', RaiseError);
  cvAvgSdv := GetProcAddress(Handle, 'cvAvgSdv', RaiseError);
  cvBackProjectPCA := GetProcAddress(Handle, 'cvBackProjectPCA', RaiseError);
  cvCalcCovarMatrix := GetProcAddress(Handle, 'cvCalcCovarMatrix', RaiseError);
  cvCalcPCA := GetProcAddress(Handle, 'cvCalcPCA', RaiseError);
  cvCartToPolar := GetProcAddress(Handle, 'cvCartToPolar', RaiseError);
  cvChangeSeqBlock := GetProcAddress(Handle, 'cvChangeSeqBlock', RaiseError);
  cvCircle := GetProcAddress(Handle, 'cvCircle', RaiseError);
  cvClearGraph := GetProcAddress(Handle, 'cvClearGraph', RaiseError);
  cvClearMemStorage := GetProcAddress(Handle, 'cvClearMemStorage', RaiseError);
  cvClearND := GetProcAddress(Handle, 'cvClearND', RaiseError);
  cvClearSeq := GetProcAddress(Handle, 'cvClearSeq', RaiseError);
  cvClearSet := GetProcAddress(Handle, 'cvClearSet', RaiseError);
  cvCmp := GetProcAddress(Handle, 'cvCmp', RaiseError);
  cvCmpS := GetProcAddress(Handle, 'cvCmpS', RaiseError);
  cvCompleteSymm := GetProcAddress(Handle, 'cvCompleteSymm', RaiseError);
  cvConvertScale := GetProcAddress(Handle, 'cvConvertScale', RaiseError);
  cvConvertScaleAbs := GetProcAddress(Handle, 'cvConvertScaleAbs', RaiseError);
  cvCopy := GetProcAddress(Handle, 'cvCopy', RaiseError);
  cvCopyImage := GetProcAddress(Handle, 'cvCopy', RaiseError);
  cvCreateData := GetProcAddress(Handle, 'cvCreateData', RaiseError);
  cvCreateSeqBlock := GetProcAddress(Handle, 'cvCreateSeqBlock', RaiseError);
  cvCrossProduct := GetProcAddress(Handle, 'cvCrossProduct', RaiseError);
  cvCvtPixToPlane := GetProcAddress(Handle, 'cvSplit', RaiseError);
  cvCvtPlaneToPix := GetProcAddress(Handle, 'cvMerge', RaiseError);
  cvCvtScale := GetProcAddress(Handle, 'cvConvertScale', RaiseError);
  cvCvtScaleAbs := GetProcAddress(Handle, 'cvConvertScaleAbs', RaiseError);
  cvCvtSeqToArray := GetProcAddress(Handle, 'cvCvtSeqToArray', RaiseError);
  cvDCT := GetProcAddress(Handle, 'cvDCT', RaiseError);
  cvDFT := GetProcAddress(Handle, 'cvDFT', RaiseError);
  cvDiv := GetProcAddress(Handle, 'cvDiv', RaiseError);
  cvDrawContours := GetProcAddress(Handle, 'cvDrawContours', RaiseError);
  cvEigenVV := GetProcAddress(Handle, 'cvEigenVV', RaiseError);
  cvEllipse := GetProcAddress(Handle, 'cvEllipse', RaiseError);
  cvEndWriteStruct := GetProcAddress(Handle, 'cvEndWriteStruct', RaiseError);
  cvError := GetProcAddress(Handle, 'cvError', RaiseError);
  cvExp := GetProcAddress(Handle, 'cvExp', RaiseError);
  cvFFT := GetProcAddress(Handle, 'cvDFT', RaiseError);
  cvFillConvexPoly := GetProcAddress(Handle, 'cvFillConvexPoly', RaiseError);
  cvFillPoly := GetProcAddress(Handle, 'cvFillPoly', RaiseError);
  cvFlip := GetProcAddress(Handle, 'cvFlip', RaiseError);
  cvFlushSeqWriter := GetProcAddress(Handle, 'cvFlushSeqWriter', RaiseError);
  cvFree_ := GetProcAddress(Handle, 'cvFree_', RaiseError);
  cvGEMM := GetProcAddress(Handle, 'cvGEMM', RaiseError);
  cvGetModuleInfo := GetProcAddress(Handle, 'cvGetModuleInfo', RaiseError);
  cvGetRawData := GetProcAddress(Handle, 'cvGetRawData', RaiseError);
  cvGetTextSize := GetProcAddress(Handle, 'cvGetTextSize', RaiseError);
  cvGraphRemoveEdge := GetProcAddress(Handle, 'cvGraphRemoveEdge', RaiseError);
  cvGraphRemoveEdgeByPtr := GetProcAddress(Handle, 'cvGraphRemoveEdgeByPtr', RaiseError);
  cvInitFont := GetProcAddress(Handle, 'cvInitFont', RaiseError);
  cvInitTreeNodeIterator := GetProcAddress(Handle, 'cvInitTreeNodeIterator', RaiseError);
  cvInRange := GetProcAddress(Handle, 'cvInRange', RaiseError);
  cvInRangeS := GetProcAddress(Handle, 'cvInRangeS', RaiseError);
  cvInsertNodeIntoTree := GetProcAddress(Handle, 'cvInsertNodeIntoTree', RaiseError);
  cvLine := GetProcAddress(Handle, 'cvLine', RaiseError);
  cvLog := GetProcAddress(Handle, 'cvLog', RaiseError);
  cvLUT := GetProcAddress(Handle, 'cvLUT', RaiseError);
  cvMatMulAddEx := GetProcAddress(Handle, 'cvGEMM', RaiseError);
  cvMatMulAddS := GetProcAddress(Handle, 'cvTransform', RaiseError);
  cvMax := GetProcAddress(Handle, 'cvMax', RaiseError);
  cvMaxS := GetProcAddress(Handle, 'cvMaxS', RaiseError);
  cvMerge := GetProcAddress(Handle, 'cvMerge', RaiseError);
  cvMin := GetProcAddress(Handle, 'cvMin', RaiseError);
  cvMinMaxLoc := GetProcAddress(Handle, 'cvMinMaxLoc', RaiseError);
  cvMinS := GetProcAddress(Handle, 'cvMinS', RaiseError);
  cvMirror := GetProcAddress(Handle, 'cvFlip', RaiseError);
  cvMixChannels := GetProcAddress(Handle, 'cvMixChannels', RaiseError);
  cvMul := GetProcAddress(Handle, 'cvMul', RaiseError);
  cvMulSpectrums := GetProcAddress(Handle, 'cvMulSpectrums', RaiseError);
  cvMulTransposed := GetProcAddress(Handle, 'cvMulTransposed', RaiseError);
  cvNormalize := GetProcAddress(Handle, 'cvNormalize', RaiseError);
  cvNot := GetProcAddress(Handle, 'cvNot', RaiseError);
  cvOr := GetProcAddress(Handle, 'cvOr', RaiseError);
  cvOrS := GetProcAddress(Handle, 'cvOrS', RaiseError);
  cvPerspectiveTransform := GetProcAddress(Handle, 'cvPerspectiveTransform', RaiseError);
  cvPolarToCart := GetProcAddress(Handle, 'cvPolarToCart', RaiseError);
  cvPolyLine := GetProcAddress(Handle, 'cvPolyLine', RaiseError);
  cvPow := GetProcAddress(Handle, 'cvPow', RaiseError);
  cvProjectPCA := GetProcAddress(Handle, 'cvProjectPCA', RaiseError);
  cvPutText := GetProcAddress(Handle, 'cvPutText', RaiseError);
  cvRandArr := GetProcAddress(Handle, 'cvRandArr', RaiseError);
  cvRandShuffle := GetProcAddress(Handle, 'cvRandShuffle', RaiseError);
  cvRawDataToScalar := GetProcAddress(Handle, 'cvRawDataToScalar', RaiseError);
  cvReadRawData := GetProcAddress(Handle, 'cvReadRawData', RaiseError);
  cvReadRawDataSlice := GetProcAddress(Handle, 'cvReadRawDataSlice', RaiseError);
  cvRectangle := GetProcAddress(Handle, 'cvRectangle', RaiseError);
  cvRectangleR := GetProcAddress(Handle, 'cvRectangleR', RaiseError);
  cvReduce := GetProcAddress(Handle, 'cvReduce', RaiseError);
  cvRegisterType := GetProcAddress(Handle, 'cvRegisterType', RaiseError);
  cvRelease := GetProcAddress(Handle, 'cvRelease', RaiseError);
  cvReleaseData := GetProcAddress(Handle, 'cvReleaseData', RaiseError);
  cvReleaseFileStorage := GetProcAddress(Handle, 'cvReleaseFileStorage', RaiseError);
  cvReleaseGraphScanner := GetProcAddress(Handle, 'cvReleaseGraphScanner', RaiseError);
  cvReleaseImage := GetProcAddress(Handle, 'cvReleaseImage', RaiseError);
  cvReleaseImageHeader := GetProcAddress(Handle, 'cvReleaseImageHeader', RaiseError);
  cvReleaseMat := GetProcAddress(Handle, 'cvReleaseMat', RaiseError);
  cvReleaseMemStorage := GetProcAddress(Handle, 'cvReleaseMemStorage', RaiseError);
  cvReleaseSparseMat := GetProcAddress(Handle, 'cvReleaseSparseMat', RaiseError);
  cvRemoveNodeFromTree := GetProcAddress(Handle, 'cvRemoveNodeFromTree', RaiseError);
  cvRepeat := GetProcAddress(Handle, 'cvRepeat', RaiseError);
  cvResetImageROI := GetProcAddress(Handle, 'cvResetImageROI', RaiseError);
  cvRestoreMemStoragePos := GetProcAddress(Handle, 'cvRestoreMemStoragePos', RaiseError);
  cvSave := GetProcAddress(Handle, 'cvSave', RaiseError);
  cvSaveMemStoragePos := GetProcAddress(Handle, 'cvSaveMemStoragePos', RaiseError);
  cvScalarToRawData := GetProcAddress(Handle, 'cvScalarToRawData', RaiseError);
  cvScale := GetProcAddress(Handle, 'cvConvertScale', RaiseError);
  cvScaleAdd := GetProcAddress(Handle, 'cvScaleAdd', RaiseError);
  cvSeqInsertSlice := GetProcAddress(Handle, 'cvSeqInsertSlice', RaiseError);
  cvSeqInvert := GetProcAddress(Handle, 'cvSeqInvert', RaiseError);
  cvSeqPop := GetProcAddress(Handle, 'cvSeqPop', RaiseError);
  cvSeqPopFront := GetProcAddress(Handle, 'cvSeqPopFront', RaiseError);
  cvSeqPopMulti := GetProcAddress(Handle, 'cvSeqPopMulti', RaiseError);
  cvSeqPushMulti := GetProcAddress(Handle, 'cvSeqPushMulti', RaiseError);
  cvSeqRemove := GetProcAddress(Handle, 'cvSeqRemove', RaiseError);
  cvSeqRemoveSlice := GetProcAddress(Handle, 'cvSeqRemoveSlice', RaiseError);
  cvSeqSort := GetProcAddress(Handle, 'cvSeqSort', RaiseError);
  cvSet := GetProcAddress(Handle, 'cvSet', RaiseError);
  cvSet1D := GetProcAddress(Handle, 'cvSet1D', RaiseError);
  cvSet2D := GetProcAddress(Handle, 'cvSet2D', RaiseError);
  cvSet3D := GetProcAddress(Handle, 'cvSet3D', RaiseError);
  cvSetData := GetProcAddress(Handle, 'cvSetData', RaiseError);
  cvSetErrStatus := GetProcAddress(Handle, 'cvSetErrStatus', RaiseError);
  cvSetIdentity := GetProcAddress(Handle, 'cvSetIdentity', RaiseError);
  cvSetImageCOI := GetProcAddress(Handle, 'cvSetImageCOI', RaiseError);
  cvSetImageROI := GetProcAddress(Handle, 'cvSetImageROI', RaiseError);
  cvSetIPLAllocators := GetProcAddress(Handle, 'cvSetIPLAllocators', RaiseError);
  cvSetMemoryManager := GetProcAddress(Handle, 'cvSetMemoryManager', RaiseError);
  cvSetND := GetProcAddress(Handle, 'cvSetND', RaiseError);
  cvSetNumThreads := GetProcAddress(Handle, 'cvSetNumThreads', RaiseError);
  cvSetReal1D := GetProcAddress(Handle, 'cvSetReal1D', RaiseError);
  cvSetReal2D := GetProcAddress(Handle, 'cvSetReal2D', RaiseError);
  cvSetReal3D := GetProcAddress(Handle, 'cvSetReal3D', RaiseError);
  cvSetRealND := GetProcAddress(Handle, 'cvSetRealND', RaiseError);
  cvSetRemove := GetProcAddress(Handle, 'cvSetRemove', RaiseError);
  cvSetSeqBlockSize := GetProcAddress(Handle, 'cvSetSeqBlockSize', RaiseError);
  cvSetSeqReaderPos := GetProcAddress(Handle, 'cvSetSeqReaderPos', RaiseError);
  cvSetZero := GetProcAddress(Handle, 'cvSetZero', RaiseError);
  cvSolvePoly := GetProcAddress(Handle, 'cvSolvePoly', RaiseError);
  cvSort := GetProcAddress(Handle, 'cvSort', RaiseError);
  cvSplit := GetProcAddress(Handle, 'cvSplit', RaiseError);
  cvStartAppendToSeq := GetProcAddress(Handle, 'cvStartAppendToSeq', RaiseError);
  cvStartNextStream := GetProcAddress(Handle, 'cvStartNextStream', RaiseError);
  cvStartReadRawData := GetProcAddress(Handle, 'cvStartReadRawData', RaiseError);
  cvStartReadSeq := GetProcAddress(Handle, 'cvStartReadSeq', RaiseError);
  cvStartWriteSeq := GetProcAddress(Handle, 'cvStartWriteSeq', RaiseError);
  cvStartWriteStruct := GetProcAddress(Handle, 'cvStartWriteStruct', RaiseError);
  cvSub := GetProcAddress(Handle, 'cvSub', RaiseError);
  cvSubRS := GetProcAddress(Handle, 'cvSubRS', RaiseError);
  cvSVBkSb := GetProcAddress(Handle, 'cvSVBkSb', RaiseError);
  cvSVD := GetProcAddress(Handle, 'cvSVD', RaiseError);
  cvT := GetProcAddress(Handle, 'cvTranspose', RaiseError);
  cvTransform := GetProcAddress(Handle, 'cvTransform', RaiseError);
  cvTranspose := GetProcAddress(Handle, 'cvTranspose', RaiseError);
  cvUnregisterType := GetProcAddress(Handle, 'cvUnregisterType', RaiseError);
  cvWrite := GetProcAddress(Handle, 'cvWrite', RaiseError);
  cvWriteComment := GetProcAddress(Handle, 'cvWriteComment', RaiseError);
  cvWriteFileNode := GetProcAddress(Handle, 'cvWriteFileNode', RaiseError);
  cvWriteInt := GetProcAddress(Handle, 'cvWriteInt', RaiseError);
  cvWriteRawData := GetProcAddress(Handle, 'cvWriteRawData', RaiseError);
  cvWriteReal := GetProcAddress(Handle, 'cvWriteReal', RaiseError);
  cvWriteString := GetProcAddress(Handle, 'cvWriteString', RaiseError);
  cvXor := GetProcAddress(Handle, 'cvXor', RaiseError);
  cvXorS := GetProcAddress(Handle, 'cvXorS', RaiseError);
  cvZero := GetProcAddress(Handle, 'cvSetZero', RaiseError);
end;

(* function cvCreateImageHeader(size: TCvSize; depth: Integer; channels: Integer): pIplImage; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvInitImageHeader(image: pIplImage; size: TCvSize; depth: Integer; channels: Integer; origin: Integer = 0; align: Integer = 4): pIplImage; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvCreateImage(size: TCvSize; depth, channels: Integer): pIplImage; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvReleaseImageHeader(var image: pIplImage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvReleaseImage(var image: pIplImage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvCloneImage(const image: pIplImage): pIplImage; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvSetImageCOI(image: pIplImage; coi: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvGetImageCOI(const image: pIplImage): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvSetImageROI(image: pIplImage; rect: TCvRect); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvResetImageROI(image: pIplImage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvGetImageROI(const image: pIplImage): TCvRect; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvCreateMatHeader(rows: Integer; cols: Integer; cType: Integer): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvInitMatHeader(mat: pCvMat; rows: Integer; cols: Integer; _type: Integer; data: Pointer = nil; step: Integer = CV_AUTOSTEP): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvCreateMat(rows, cols, cType: Integer): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvReleaseMat(var mat: pCvMat); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvCloneMat(const mat: pCvMat): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvGetSubRect(arr: pCvArr; submat: pCvArr; rect: TCvRect): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvGetSubArr(arr: pCvArr; submat: pCvArr; rect: TCvRect): pCvMat; cdecl; external core_lib name 'cvGetSubRect'; *)

function cvGetRow(const arr: pCvArr; submat: pCvMat; row: Integer): pCvMat;
begin
  result := cvGetRows(arr, submat, row, row + 1, 1);
end;

(* function cvGetCols(const arr: pCvArr; submat: pCvMat; start_col, end_col: Integer): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

function cvGetCol(const arr: pCvArr; submat: pCvMat; col: Integer): pCvMat;
begin
  result := cvGetCols(arr, submat, col, col + 1);
end;

(* function cvGetDiag(const arr: pCvArr; submat: pCvMat; diag: Integer = 0): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvScalarToRawData(const scalar: pCvScalar; data: pCvArr; cType: Integer; extend_to_12: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvRawDataToScalar(const data: pCvArr; cType: Integer; scalar: pCvScalar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvCreateMatNDHeader(dims: Integer; const sizes: pInteger; cType: Integer): pCvMatND; cdecl;external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* function cvCreateMatND(dims: Integer; const sizes: pInteger; cType: Integer):pCvMatND; cdecl;external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvInitMatNDHeader(mat: pCvMatND; dims: Integer; const sizes: pInteger; cType: Integer; data: pCvArr = nil):pCvMatND; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

procedure cvReleaseMatND(var mat: pCvMatND); {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  cvReleaseMat(pCvMat(mat));
end;

(* function cvCloneMatND(const mat: pCvMatND):pCvMatND; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCreateSparseMat(dims: Integer; sizes: pInteger; cType: Integer):pCvSparseMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvReleaseSparseMat(mat: pCvSparseMat); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCloneSparseMat(const mat: pCvSparseMat):pCvSparseMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvInitSparseMatIterator(const mat: pCvSparseMat; mat_iterator: pCvSparseMatIterator):pCvSparseNode; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

{
 returns next sparse array node (or NULL if there is no more nodes)
 CV_INLINE CvSparseNode* cvGetNextSparseNode( CvSparseMatIterator* mat_iterator )
 }{
 if( mat_iterator->node->next )
 return mat_iterator->node = mat_iterator->node->next;
 else
 }{
 int idx;
 for( idx = ++mat_iterator->curidx; idx < mat_iterator->mat->hashsize; idx++ )
 }{
 CvSparseNode* node = (CvSparseNode*)mat_iterator->mat->hashtable[idx];
 if( node )
 }{
 mat_iterator->curidx = idx;
 return mat_iterator->node = node;
 }{
 }{
 return NULL;
 }{
 }

{$IFDEF DELPHIXE_UP}

function cvGetNextSparseNode(mat_iterator: pCvSparseMatIterator): pCvSparseNode;
var
  idx: Integer;
  node: pCvSparseNode;
begin
  if Assigned(mat_iterator^.node^.next) then
  begin
    mat_iterator^.node := mat_iterator^.node^.next;
    result := mat_iterator^.node;
  end
  else
  begin
    Inc(mat_iterator^.curidx);
    for idx := mat_iterator^.curidx to mat_iterator^.mat^.hashsize - 1 do
    begin
      node := mat_iterator^.mat^.hashtable[idx];
      if Assigned(node) then
      begin
        mat_iterator^.curidx := idx;
        mat_iterator^.node := node;
        result := mat_iterator^.node;
        exit;
      end;
    end;
    result := nil;
  end;
end;
{$ENDIF}
(* function cvInitNArrayIterator(count: Integer; arrs: pCvArr; const mask: pCvArr; stubs: pCvMatND; array_iterator: pCvNArrayIterator; flags: Integer = 0): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvNextNArraySlice(array_iterator: pCvNArrayIterator): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetElemType(const arr: pCvArr): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetDims(const arr: pCvArr; sizes: pInteger = nil): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetDimSize(const arr: pCvArr; index: Integer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvPtr1D(const arr: pCvArr; idx0: Integer; cType: pInteger = nil): pCvArr; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvPtr2D(const arr: pCvArr; idx0, idx1: Integer; cType: pInteger = nil): pCvArr; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvPtr3D(const arr: pCvArr; idx0, idx1, idx2: Integer; cType: pInteger = nil): pCvArr; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvPtrND(const arr: pCvArr; idx: pInteger; cType: pInteger = nil; create_node: Integer = 1; precalc_hashval: punsigned = nil): pCvArr; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGet1D(const arr: pCvArr; idx0: Integer): TCvScalar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGet2D(const arr: pCvArr; idx0, idx1: Integer): TCvScalar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGet3D(const arr: pCvArr; idx0, idx1, idx2: Integer): TCvScalar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetND(const arr: pCvArr; idx: pInteger): TCvScalar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

// (* function cvGetReal1D(const arr: pIplImage; idx0: Integer): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* function cvGetReal1D(const arr: pCvArr; idx0: Integer): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// (* function cvGetReal2D(const arr: pCvMat; idx0, idx1: Integer): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* function cvGetReal2D(const arr: pCvArr; idx0, idx1: Integer): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

(* function cvGetReal3D(const arr: pCvArr; idx0, idx1, idx2: Integer): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetRealND(const arr: pCvArr; idx: pInteger): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSet1D(arr: pCvArr; idx0: Integer; value: TCvScalar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSet2D(arr: pCvArr; idx0, idx1: Integer; value: TCvScalar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSet3D(arr: pCvArr; idx0, idx1, idx2: Integer; value: TCvScalar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetND(arr: pCvArr; idx: pInteger; value: TCvScalar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetReal1D(arr: pCvArr; idx0: Integer; value: double); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetReal2D(arr: pCvArr; idx0, idx1: Integer; value: double); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetReal3D(arr: pCvArr; idx0, idx1, idx2: Integer; value: double); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetRealND(arr: pCvArr; idx: pInteger; value: double); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvClearND(arr: pCvArr; idx: pInteger); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetMat(const arr: pCvArr; header: pCvMat; coi: pInteger = nil; allowND: Integer = 0): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetImage(const arr: pCvArr; image_header: pIplImage): pIplImage; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvReshapeMatND(const arr: pCvArr; sizeof_header: Integer; header: pCvArr; new_cn, new_dims: Integer; new_sizes: pInteger): pCvArr; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

function cvReshapeND(const arr: pCvArr; sizeof_header: Integer; header: pCvArr; new_cn, new_dims: Integer; new_sizes: {$IF Defined(FPC) and Defined(MSWINDOWS)}objpas.{$ENDIF}pInteger): pCvArr;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  result := cvReshapeMatND(arr, sizeof(sizeof_header), header, new_cn, new_dims, new_sizes);
end;

(* function cvReshape(const arr: pCvArr; header: pCvMat; new_cn: Integer; new_rows: Integer = 0): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvRepeat(src, dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCreateData(arr: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvReleaseData(arr: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetData(arr: pCvArr; data: Pointer; step: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvGetRawData(arr: pCvArr; data: pByte; step: pInteger = nil; roi_size: pCvSize = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

// (* procedure cvCopy; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvCopy(const src: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
// (* procedure cvCopy(const src: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

(* procedure cvSet(arr: pCvArr; value: TCvScalar; const mask: pCvArr = Nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(*
procedure cvSet(mat: pCvMat; i, j: Integer; val: Single); {$IFDEF USE_INLINE} inline; {$ENDIF}
var
  // type_: Integer;
  ptr: pByte;
  pf: PSingle;
begin
  // type_ := CV_MAT_TYPE(mat._type);
  assert((i < mat^.rows) and (j < mat^.cols) and (CV_MAT_TYPE(mat^._type) = CV_32FC1));
  ptr := mat^.data.ptr;
  Inc(ptr, mat^.step * i + sizeof(Single) * j);
  pf := PSingle(ptr);
  pf^ := val;
end;
*)

(* procedure cvSetZero(arr: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvZero(arr: pCvArr); cdecl; external core_lib name 'cvSetZero'; *)

(* procedure cvSplit(const src: pCvArr; dst0: pCvArr; dst1: pCvArr; dst2: pCvArr = nil; dst3: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

// (* procedure cvMerge(const src0: pIplImage; const src1: pIplImage; const src2: pIplImage; const src3: pIplImage; dst: pIplImage); cdecl; *)
// external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload;
(* procedure cvMerge(const src0: pCvArr; const src1: pCvArr; const src2: pCvArr; const src3: pCvArr; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

(* procedure cvMixChannels(src: array of pCvArr; src_count: Integer; dst: array of pCvArr; dst_count: Integer; const from_to: pInteger;
  pair_count: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvConvertScale(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

procedure cvConvert(const src: pCvArr; dst: pCvArr); {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  cvConvertScale(src, dst, 1, 0);
end;

(* procedure cvScale(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl; external core_lib name 'cvConvertScale'; *)

(* procedure cvCvtScale(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl; external core_lib name 'cvConvertScale'; *)

(* procedure cvConvertScaleAbs(const src: pCvArr; dst: pCvArr; scale: double = 1; shift: double = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCvtScaleAbs; cdecl; external core_lib name 'cvConvertScaleAbs'; *)

(* function cvCheckTermCriteria(criteria: TCvTermCriteria; default_eps: double; default_max_iters: Integer): TCvTermCriteria; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

// (* procedure cvAdd; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvAdd(const src1, src2: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvAdd(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// (* procedure cvAddS; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvAddS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvAddS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// (* procedure cvSub; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvSub(const src1, src2: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvSub(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

procedure cvSubS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr); overload;
begin
  cvAddS(src, CvScalar(-value.val[0], -value.val[1], -value.val[2], -value.val[3]), dst, mask);
end;

procedure cvSubS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage); overload;
begin
  cvAddS(src, CvScalar(-value.val[0], -value.val[1], -value.val[2], -value.val[3]), dst, mask);
end;

// (* procedure cvSubRS; external *) core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF};
// (* procedure cvSubRS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pIplImage = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvSubRS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// (* procedure cvMul; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvMul(const src1, src2: pIplImage; dst: pIplImage; scale: double = 1); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvMul(const src1, src2: pCvArr; dst: pCvArr; scale: double = 1); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// (* procedure cvDiv; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvDiv(const src1, src2: pIplImage; dst: pIplImage; scale: double = 1); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvDiv(const src1, src2: pCvArr; dst: pCvArr; scale: double = 1); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// (* procedure cvScaleAdd; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvScaleAdd(const src1: pIplImage; scale: TCvScalar; const src2: pIplImage; dst: pIplImage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvScaleAdd(const src1: pCvArr; scale: TCvScalar; const src2: pCvArr; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// define cvAXPY( A, real_scalar, B, C ) cvScaleAdd(A, cvRealScalar(real_scalar), B, C)
procedure cvAXPY(A: pCvArr; real_scalar: double; B, C: pCvArr); {$IFDEF USE_INLINE} inline; {$ENDIF} overload;
begin
  cvScaleAdd(A, cvRealScalar(real_scalar), B, C);
end;

procedure cvAXPY(A: pIplImage; real_scalar: double; B, C: pIplImage); {$IFDEF USE_INLINE} inline; {$ENDIF} overload;
begin
  cvScaleAdd(A, cvRealScalar(real_scalar), B, C);
end;

// (* procedure cvAddWeighted; external *) core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF};
// (* procedure cvAddWeighted(const src1: pIplImage; alpha: double; const src2: pIplImage; beta: double; gamma: double; dst: pIplImage); cdecl; *)
// external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload;
(* procedure cvAddWeighted(const src1: pCvArr; alpha: double; const src2: pCvArr; beta: double; gamma: double; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

(* function cvDotProduct(const src1, src2: pCvArr): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvAlloc(size: NativeUInt): Pointer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvFree_(ptr: Pointer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvInitFont(font: pCvFont; font_face: Integer; hscale: double; vscale: double; shear: double = 0; thickness: Integer = 1;
  line_type: Integer = 8); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvPutText(img: pCvArr; const text: pCvChar; org: TCvPoint; const font: pCvFont; color: TCvScalar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

function cvFont(scale: double; thickness: Integer = 1): TCvFont; {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  cvInitFont(@result, CV_FONT_HERSHEY_PLAIN, scale, scale, 0, thickness, CV_AA);
end;

(* procedure cvCircle(img: pCvArr; center: TCvPoint; radius: Integer; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvLine(img: pCvArr; pt1, pt2: TCvPoint; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

// (* procedure cvCopyImage; external core_lib name 'cvCopy'; *)
// (* procedure cvCopyImage(const src: pIplImage; dst: pIplImage; const mask: pIplImage = nil); cdecl; external core_lib name 'cvCopy'; overload; *)
// (* procedure cvCopyImage(const src: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib name 'cvCopy'; overload; *)

function CV_RGB(const r, g, B: double): TCvScalar; {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  result := CvScalar(B, g, r, 0);
end;

(* procedure cvSave(const filename: pCvChar; const struct_ptr: Pointer; const name: pCvChar; const comment: pCvChar; attributes: TCvAttrList); cdecl;
  external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

(*
procedure cvSave(const filename: pCvChar; const struct_ptr: Pointer; const name: pCvChar = Nil; const comment: pCvChar = Nil); overload;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  cvSave(filename, struct_ptr, name, comment, ZeroCvAttrList);
end;
*)

(* function cvLoad(const filename: pCvChar; memstorage: pCvMemStorage = Nil; const name: pCvChar = nil; const real_name: ppCvChar = nil): Pointer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

// (* procedure cvInRange; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvInRange(const src: pIplImage; const lower: pIplImage; const upper: pIplImage; dst: pIplImage); cdecl; *)
// external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload;
(* procedure cvInRange(const src: pCvArr; const lower: pCvArr; const upper: pCvArr; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// (* procedure cvInRangeS; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvInRangeS(const src: pIplImage; lower: TCvScalar; upper: TCvScalar; dst: pIplImage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvInRangeS(const src: pCvArr; lower: TCvScalar; upper: TCvScalar; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// (* procedure cvMinMaxLoc; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvMinMaxLoc(const arr: pIplImage; min_val: pDouble; max_val: pDouble; min_loc: pCVPoint = nil; max_loc: pCVPoint = nil;
// const mask: pIplImage = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvMinMaxLoc(const arr: pCvArr; min_val: pDouble; max_val: pDouble; min_loc: pCVPoint = nil; max_loc: pCVPoint = nil; const mask: pCvArr = nil); cdecl;
  external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

// (* procedure cvAnd; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvAnd(const src1: pIplImage; const src2: pIplImage; dst: pIplImage; masl: pIplImage = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvAnd(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; masl: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

(* function cvCreateMemStorage(block_size: Integer = 0): pCvMemStorage; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetSeqElem(const seq: pCvSeq; index: Integer): Pointer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvReleaseMemStorage(var storage: pCvMemStorage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvRectangle(img: pCvArr; pt1: TCvPoint; pt2: TCvPoint; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetRows(const arr: pCvArr; submat: pCvMat; start_row, end_row: Integer; delta_row: Integer = 1): pCvMat; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvFlip(const src: pCvArr; dst: pCvArr = nil; flip_mode: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvMirror(const src: pCvArr; dst: pCvArr = nil; flip_mode: Integer = 0); cdecl; external core_lib name 'cvFlip'; *)

(* procedure cvClearMemStorage(storage: pCvMemStorage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvDrawContours(img: pIplImage; contour: pCvSeq; external_color, hole_color: TCvScalar; max_level, thickness { =1 } , line_type: Integer { =8 };
  offset: TCvPoint { =cvPoint(0,0) } ); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCreateChildMemStorage(parent: pCvMemStorage): pCvMemStorage; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCvtSeqToArray(const seq: pCvSeq; elements: pCvArr; slice: TCvSlice { =CV_WHOLE_SEQ } ); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvOpenFileStorage(const filename: pCvChar; memstorage: pCvMemStorage; flags: Integer; const encoding: pCvChar = nil): pCvFileStorage; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvReleaseFileStorage(var fs: pCvFileStorage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetFileNodeByName(const fs: pCvFileStorage; const map: pCvFileNode; const name: pCvChar): pCvFileNode; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

function cvReadInt(const node: pCvFileNode; default_value: Integer = 0): Integer; {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  // return !node ? default_value :
  // CV_NODE_IS_INT(node->tag) ? node->data.i :
  // CV_NODE_IS_REAL(node->tag) ? cvRound(node->data.f) : 0x7fffffff;
  result := iif(not Assigned(node), default_value, iif(CV_NODE_IS_INT(node^.tag), node^.i, iif(CV_NODE_IS_REAL(node^.tag), node^.F, $7FFFFFFF)));
end;

function cvReadIntByName(const fs: pCvFileStorage; const map: pCvFileNode; const name: pCvChar; default_value: Integer = 0): Integer;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  // return cvReadInt( cvGetFileNodeByName( fs, map, name ), default_value );
  result := cvReadInt(cvGetFileNodeByName(fs, map, name), default_value);
end;

(* function cvRead(fs: pCvFileStorage; node: pCvFileNode; attributes: pCvAttrList = nil): pPointer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvStartReadSeq(const seq: Pointer; reader: pCvSeqReader; reverse: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvChangeSeqBlock(reader: pCvSeqReader; direction: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvFillConvexPoly(img: pCvArr; const pts: pCVPoint; npts: Integer; color: TCvScalar; line_type: Integer = 8; shift: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvPolyLine(img: pCvArr; pts: pCVPoint; const npts: pInteger; contours: Integer; is_closed: Integer; color: TCvScalar; thickness: Integer = 1;
  line_type: Integer = 8; shift: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCreateSeq(seq_flags: Integer; header_size: NativeUInt; elem_size: NativeUInt; storage: pCvMemStorage): pCvSeq; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCreateSeqBlock(writer: pCvSeqWriter); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSeqPush(seq: pCvSeq; const element: Pointer = nil): Pointer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

procedure cvEllipseBox(img: pCvArr; box: TCvBox2D; color: TCvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0);
{$IFDEF USE_INLINE} inline; {$ENDIF}
var
  axes: TCvSize;
begin
  axes.width := cvRound(box.size.width * 0.5);
  axes.height := cvRound(box.size.height * 0.5);
  cvEllipse(img, cvPointFrom32f(box.center), axes, box.angle, 0, 360, color, thickness, line_type, shift);
end;

(* procedure cvOr(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvXor(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

// (* procedure cvXorS; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
// (* procedure cvXorS(const src: pIplImage; value: TCvScalar; dst: pIplImage; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* procedure cvXorS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

(* procedure cvNot(const src: pCvArr; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvEllipse(img: pCvArr; center: TCvPoint; axes: TCvSize; angle: double; start_angle: double; nd_angle: double; color: TCvScalar;
  thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

procedure cvFree(var ptr); {$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  // #define cvFree(ptr) (cvFree_(*(ptr)), *(ptr)=0)
  cvFree_(@ptr);
  Pointer(ptr) := nil;
end;

// (* function cvCountNonZero(arr: pIplImage): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)
(* function cvCountNonZero(arr: pCvArr): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; overload; *)

function cvGet(const mat: pCvMat; i, j: Integer): Single; {$IFDEF USE_INLINE} inline; {$ENDIF}
var
  // type_: Integer;
  ptr: pByte;
  pf: PSingle;
begin
  // type_ := CV_MAT_TYPE(mat^._type);
  assert((i < mat^.rows) and (j < mat^.cols) and (CV_MAT_TYPE(mat^._type) = CV_32FC1));
  ptr := mat^.data.ptr;
  Inc(ptr, mat^.step * i + sizeof(Single) * j);
  pf := PSingle(ptr);
  result := pf^;
end;

(* procedure cvRelease(var struct_ptr: Pointer); cdecl; external core_lib name 'cvRelease'; *)

(* procedure cvRelease(var struct_ptr: pCvSeq); cdecl; external core_lib name 'cvRelease'; *)

(* function cvGetTickCount: int64; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetTickFrequency: double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCheckHardwareSupport(feature: Integer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetNumThreads: Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetNumThreads(threads: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetThreadNum: Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvAbsDiff(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvNorm(const arr1: pCvArr; const arr2: pCvArr = nil; norm_type: Integer = CV_L2; const mask: pCvArr = nil): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSeqRemove(seq: pCvSeq; index: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvClearSeq(seq: pCvSeq); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvWrite(fs: pCvFileStorage; const name: pCvChar; const ptr: pCvArr; attributes: TCvAttrList { = cvAttrList() } ); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSeqPartition(const seq: pCvSeq; storage: pCvMemStorage; labels: pCvSeq; is_equal: TCvCmpFunc; userdata: Pointer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSum(const arr: pCvArr): TCvScalar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvRandArr(rng: pCvRNG; arr: pCvArr; dist_type: Integer; param1: TCvScalar; param2: TCvScalar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvRandShuffle(mat: pCvArr; rng: pCvRNG; iter_factor: double = 1); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvWriteInt(fs: pCvFileStorage; const name: pCvChar; value: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvWriteReal(fs: pCvFileStorage; const name: pCvChar; value: double); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvWriteString(fs: pCvFileStorage; const name: pCvChar; const str: pCvChar; quote: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvWriteComment(fs: pCvFileStorage; const comment: pCvChar; eol_comment: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

function cvReadByName(fs: pCvFileStorage; const map: pCvFileNode; const name: pCvChar; attributes: pCvAttrList = nil): Pointer;
begin
  result := cvRead(fs, cvGetFileNodeByName(fs, map, name), attributes);
end;

function cvReadStringByName(const fs: pCvFileStorage; const map: pCvFileNode; const name: pCvChar; const default_value: pCvChar = nil): pCvChar;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  result := cvReadString(cvGetFileNodeByName(fs, map, name), default_value);
end;

function cvReadString(const node: pCvFileNode; const default_value: pCvChar = nil): pCvChar; {$IFDEF USE_INLINE} inline;
{$ENDIF}
begin
  if Assigned(node) then
  begin
    if CV_NODE_IS_STRING(node^.tag) then
      result := node^.str.ptr
    else
      result := nil;
  end
  else
    result := default_value;
end;

(* function cvGetErrStatus: Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetErrStatus(status: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetErrMode: Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSetErrMode(mode: Integer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvError(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar = nil; line: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvDFT(const src: pCvArr; dst: pCvArr; flags: Integer; nonzero_rows: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvFFT(const src: pCvArr; dst: pCvArr; flags: Integer; nonzero_rows: Integer = 0); cdecl; external core_lib name 'cvDFT'; *)

(* procedure cvMulSpectrums(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; flags: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetOptimalDFTSize(size0: Integer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvDCT(const src: pCvArr; dst: pCvArr; flags: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCartToPolar(const x: pCvArr; const y: pCvArr; magnitude: pCvArr; angle: pCvArr = nil; angle_in_degrees: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvPolarToCart(const magnitude: pCvArr; const angle: pCvArr; x: pCvArr; y: pCvArr; angle_in_degrees: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvPow(const src: pCvArr; dst: pCvArr; power: double); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvExp(const src: pCvArr; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvLog(const src: pCvArr; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCrossProduct(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

procedure cvMatMulAdd(const src1, src2, src3: pCvArr; dst: pCvArr);
begin
  cvGEMM(src1, src2, 1, src3, 1, dst, 0);
end;

(* procedure cvGEMM(const src1: pCvArr; const src2: pCvArr; alpha: double; const src3: pCvArr; beta: double; dst: pCvArr; tABC: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvMatMulAddEx(const src1: pCvArr; const src2: pCvArr; alpha: double; const src3: pCvArr; beta: double; dst: pCvArr; tABC: Integer = 0); cdecl; external core_lib name 'cvGEMM'; *)

(* function cvInvert(const src: pCvArr; dst: pCvArr; method: Integer = CV_LU): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvFastArctan(y, x: Float): Float; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCbrt(value: Float): Float; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCheckArr(const arr: pCvArr; flags: Integer = 0; min_val: double = 0; max_val: double = 0): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvGetTextSize(const text_string: pCvChar; const font: pCvFont; text_size: pCvSize; var baseline: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvInitTreeNodeIterator(var tree_iterator: TCvTreeNodeIterator; const first: Pointer; max_level: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvNextTreeNode(tree_iterator: pCvTreeNodeIterator): Pointer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvPrevTreeNode(tree_iterator: pCvTreeNodeIterator): Pointer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvInsertNodeIntoTree(node: Pointer; parent: Pointer; frame: Pointer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvRemoveNodeFromTree(node: Pointer; frame: Pointer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvTreeToNodeSeq(const first: Pointer; header_size: Integer; storage: pCvMemStorage): pCvSeq; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvKMeans2(const samples: pCvArr; cluster_count: Integer; labels: pCvArr; termcrit: TCvTermCriteria; attempts: Integer = 1; rng: pCvRNG = nil;
  flags: Integer = 0; _centers: pCvArr = nil; compactness: pDouble = nil): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvAndS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvOrS(const src: pCvArr; value: TCvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCmp(const src1, src2: pCvArr; dst: pCvArr;  cmp_op: integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCmpS(const src: pCvArr; value: double; dst: pCvArr;  cmp_op: integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvMin(const src1, src2:pCvArr; dst:pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvMax(const src1, src2:pCvArr; dst:pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvMinS(const src:pCvArr; value:double; dst:pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvMaxS(const src:pCvArr; value:double; dst:pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvAbsDiffS(const src: pCvArr; dst: pCvArr; value:TCvScalar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSort(const src:pCvArr; dst : pCvArr = nil;
                    idxmat :pCvArr=nil;
                    flags : integer =0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSolveCubic(const coeffs: pCvMat; roots: pCvMat): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSolvePoly(const coeffs: pCvMat; roots2: pCvMat; maxiter: Integer = 20; fig: Integer = 100); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvTransform(const src: pCvArr; dst: pCvArr; const transmat: pCvMat; const shiftvec: pCvMat = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvMatMulAddS(const src: pCvArr; dst: pCvArr; const transmat: pCvMat; const shiftvec: pCvMat = nil); cdecl; external core_lib name 'cvTransform'; *)

(* procedure cvPerspectiveTransform(const src: pCvArr; dst: pCvArr; const mat: pCvMat); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvMulTransposed(const src: pCvArr; dst: pCvArr; order: Integer; const delta: pCvArr = nil; scale: double = 1); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvTranspose(const src: pCvArr; dst: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvT(const src: pCvArr; dst: pCvArr); cdecl; external core_lib name 'cvTranspose'; *)

(* procedure cvCompleteSymm(matrix: pCvMat; LtoR: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSVD(A: pCvArr; W: pCvArr; U: pCvArr = nil; V: pCvArr = nil; flags: Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSVBkSb(const W: pCvArr; const U: pCvArr; const V: pCvArr; const B: pCvArr; x: pCvArr; flags: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSolve(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; method: Integer = CV_LU): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvDet(const mat: pCvArr): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvTrace(const mat: pCvArr): TCvScalar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvEigenVV(mat: pCvArr; evects: pCvArr; evals: pCvArr; eps: double = 0; lowindex: Integer = -1; highindex: Integer = -1); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetIdentity(mat: pCvArr; value: TCvScalar { =cvRealScalar(1) } ); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvRange(mat: pCvArr; start: double; end_: double): pCvArr; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCalcCovarMatrix(const vects: pCvArrArray; count: Integer; cov_mat: pCvArr; avg: pCvArr; flags: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvCalcPCA(const data: pCvArr; mean: pCvArr; eigenvals: pCvArr; eigenvects: pCvArr; flags: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvProjectPCA(const data: pCvArr; const mean: pCvArr; const eigenvects: pCvArr; result: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvBackProjectPCA(const proj: pCvArr; const mean: pCvArr; const eigenvects: pCvArr; result: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvMahalanobis(const vec1: pCvArr; const vec2: pCvArr; const mat: pCvArr): double; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvAvg(const arr: pCvArr; const mask: pCvArr = nil): TCvScalar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvAvgSdv(const arr: pCvArr; mean: pCvScalar; std_dev: pCvScalar; const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvNormalize(const src: pCvArr; dst: pCvArr; A: double { = CV_DEFAULT(1) }; B: double { =CV_DEFAULT(0.) }; norm_type: Integer { =CV_DEFAULT(CV_L2) };
  const mask: pCvArr = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvReduce(const src: pCvArr; dst: pCvArr; dim: Integer = -1; op: Integer = CV_REDUCE_SUM); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSliceLength(slice: TCvSlice; const seq: pCvSeq): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSaveMemStoragePos(const storage:pCvMemStorage; pos:pCvMemStoragePos); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvRestoreMemStoragePos(storage:pCvMemStorage; pos:pCvMemStoragePos); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvMemStorageAlloc(storage: pCvMemStorage; size: size_t): Pointer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvMemStorageAllocString(storage: pCvMemStorage; const ptr: pCvChar; len: Integer = -1): TCvString; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetSeqBlockSize( seq:pCvSeq; delta_elems:Integer ); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSeqPushFront(seq: pCvSeq; const element: Pointer = nil): pschar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSeqPop(seq:pCvSeq; element : pointer = nil);cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSeqPopFront(seq:pCvSeq; element :pointer = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSeqPushMulti(seq:pCvSeq; const elements:pointer; count:Integer; in_front:integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSeqPopMulti(seq:pCvSeq; elements:pointer; count:integer; in_front:integer=0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSeqInsert(seq: pCvSeq; before_index: Integer; const element: Pointer = nil): pschar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSeqElemIdx(const seq: pCvSeq; const element: Pointer; block: pCvSeqBlockArray = nil): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvStartAppendToSeq(seq:pCvSeq; writer:pCvSeqWriter); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvStartWriteSeq( seq_flags:integer; header_size:Integer;
                              elem_size:Integer; storage:pCvMemStorage;
                              writer:pCvSeqWriter); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvEndWriteSeq(writer: pCvSeqWriter): pCvSeq; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvFlushSeqWriter( writer:pCvSeqWriter ); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetSeqReaderPos(reader: pCvSeqReader): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetSeqReaderPos(reader:pCvSeqReader; index:Integer; is_relative :Integer = 0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvMakeSeqHeaderForArray(seq_type: Integer; header_size: Integer; elem_size: Integer; elements: Pointer; total: Integer; seq: pCvSeq;
  block: pCvSeqBlock): pCvSeq; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSeqSlice(const seq: pCvSeq; slice: TCvSlice; storage: pCvMemStorage = nil; copy_data: Integer = 0): pCvSeq; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSeqRemoveSlice( seq:pCvSeq; slice :TCvSlice); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSeqInsertSlice(seq:pCvSeq; before_index:integer; const from_arr:pCvArr);cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSeqSort(seq:pCvSeq; func:TCvCmpFunc; userdata:pointer = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSeqSearch(seq: pCvSeq; const elem: Pointer; func: TCvCmpFunc; is_sorted: Integer; elem_idx: pInteger; userdata: Pointer = nil): pschar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSeqInvert( seq:pCvSeq );cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCreateSet(set_flags: Integer; header_size: Integer; elem_size: Integer; storage: pCvMemStorage): pCvSet; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvSetAdd(set_header: pCvSet; elem: pCvSetElem = nil; inserted_elem: pCvSetElemArray = nil): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetRemove(set_header:pCvSet; index:Integer );cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvClearSet( set_header:pCvSet ); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCreateGraph(graph_flags: Integer; header_size: Integer; vtx_size: Integer; edge_size: Integer; storage: pCvMemStorage): pCvGraph; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGraphAddVtx(graph: pCvGraph; const vtx: pCvGraphVtx = nil; inserted_vtx: pCvGraphVtxArray = nil): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGraphRemoveVtx(graph: pCvGraph; index: Integer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGraphRemoveVtxByPtr(graph: pCvGraph; vtx: pCvGraphVtx): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGraphAddEdge(graph: pCvGraph; start_idx: Integer; end_idx: Integer; const edge: pCvGraphEdge = nil; inserted_edge: pCvGraphEdgeArray = nil)
  : Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGraphAddEdgeByPtr(graph: pCvGraph; start_vtx: pCvGraphVtx; end_vtx: pCvGraphVtx; const edge: pCvGraphEdge = nil;
  inserted_edge: pCvGraphEdgeArray = nil): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvGraphRemoveEdge(graph: pCvGraph; start_idx: Integer; end_idx: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvGraphRemoveEdgeByPtr(graph: pCvGraph; start_vtx: pCvGraphVtx; end_vtx: pCvGraphVtx); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvFindGraphEdge(const graph: pCvGraph; start_idx: Integer; end_idx: Integer): pCvGraphEdge; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvFindGraphEdgeByPtr(const graph: pCvGraph; const start_vtx: pCvGraphVtx; const end_vtx: pCvGraphVtx): pCvGraphEdge; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvClearGraph(graph: pCvGraph); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGraphVtxDegree(const graph: pCvGraph; vtx_idx: Integer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGraphVtxDegreeByPtr(const graph: pCvGraph; const vtx: pCvGraphVtx): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCreateGraphScanner(graph: pCvGraph; vtx: pCvGraphVtx = nil; mask: Integer = CV_GRAPH_ALL_ITEMS): pCvGraphScanner; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvReleaseGraphScanner(var scanner: pCvGraphScanner); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvNextGraphItem(scanner: pCvGraphScanner): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvCloneGraph(const graph: pCvGraph; storage: pCvMemStorage): pCvGraph; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvRectangleR( img:pCvArr; r:TCvRect; color:TCvScalar; thickness:integer=1;
                                                      line_type :integer =8;
                                                      shift:integer=0); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvFillPoly( img:pCvArr; pts:pCvPointArray; const npts:pInteger;
                                                  contours:Integer; color:TCvScalar;
                                                  line_type :Integer=8; shift :Integer=0 ); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvClipLine(img_size: TCvSize; pt1: pCVPoint; pt2: pCVPoint): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvInitLineIterator(const image: pCvArr; pt1: TCvPoint; pt2: TCvPoint; line_iterator: pCvLineIterator; connectivity: Integer = 8;
  left_to_right: Integer = 0): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvColorToScalar(packed_color: double; arrtype: Integer): TCvScalar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvEllipse2Poly(center: TCvPoint; axes: TCvSize; angle: Integer; arc_start: Integer; arc_end: Integer; pts: pCVPoint; delta: Integer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvLUT(const src: pCvArr; dst: pCvArr; const lut: pCvArr); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvRegisterModule(const module_info: pCvModuleInfo): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvUseOptimized(on_off: Integer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvGetModuleInfo(const module_name: pCvChar; const version: ppCvChar; const loaded_addon_plugins: ppCvChar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetMemoryManager(alloc_func: TCvAllocFunc = nil; free_func: TCvFreeFunc = nil; userdata: Pointer = nil); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvSetIPLAllocators(create_header: TCv_iplCreateImageHeader; allocate_data: TCv_iplAllocateImageData; deallocate: TCv_iplDeallocate;
  create_roi: TCv_iplCreateROI; clone_image: TCv_iplCloneImage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvAttrValue(const attr: pCvAttrList; const attr_name: pCvChar): pCvChar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvStartWriteStruct( fs:pCvFileStorage; const name:pCVChar;
                                struct_flags:Integer; const type_name :pCVChar;
                                attributes:TCvAttrList); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvEndWriteStruct(fs:pCvFileStorage );cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvStartNextStream(fs: pCvFileStorage); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvWriteRawData(fs: pCvFileStorage; const src: Pointer; len: Integer; const dt: pCvChar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetHashedKey(fs: pCvFileStorage; const name: pCvChar; len: Integer = -1; create_missing: Integer = 0): pCvStringHashNode; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetRootFileNode(const fs: pCvFileStorage; stream_index: Integer = 0): pCvFileNode; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetFileNode(fs: pCvFileStorage; map: pCvFileNode; const key: pCvStringHashNode; create_missing: Integer = 0): pCvFileNode; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvStartReadRawData(const fs: pCvFileStorage; const src: pCvFileNode; reader: pCvSeqReader); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvReadRawDataSlice(const fs: pCvFileStorage; reader: pCvSeqReader; count: Integer; dst: Pointer; const dt: pCvChar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvReadRawData(const fs: pCvFileStorage; const src: pCvFileNode; dst: Pointer; const dt: pCvChar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvWriteFileNode(fs: pCvFileStorage; const new_node_name: pCvChar; const node: pCvFileNode; embed: Integer); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetFileNodeName(const node: pCvFileNode): pCvChar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvRegisterType(const info: pCvTypeInfo); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* procedure cvUnregisterType(const type_name: pCvChar); cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvFirstType: pCvTypeInfo; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvFindType(const type_name: pCvChar): pCvTypeInfo; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvTypeOf(const struct_ptr: Pointer): pCvTypeInfo; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvClone(const struct_ptr: Pointer): Pointer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvErrorStr(status: Integer): pCvChar; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGetErrInfo(const errcode_desc: ppCvChar; const description: ppCvChar; const filename: ppCvChar; line: pInteger): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvErrorFromIppStatus(ipp_status: Integer): Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvRedirectError(error_handler: TCvErrorCallback; userdata: Pointer = nil; prev_userdata: ppvoid = nil): TCvErrorCallback; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvNulDevReport(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer)
  : Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvStdErrReport(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer)
  : Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

(* function cvGuiBoxReport(status: Integer; const func_name: pCvChar; const err_msg: pCvChar; const file_name: pCvChar; line: Integer; userdata: Pointer)
  : Integer; cdecl; external core_lib{$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

procedure cvDecRefData(arr: pCvArr); {$IFDEF USE_INLINE}inline;{$ENDIF}
Var
  mat: pCvMat;
  matND: pCvMatND;
begin
  if CV_IS_MAT(arr) then
  begin
    // CvMat* mat = (CvMat*)arr;
    mat := arr;
    // mat->data.ptr = NULL;
    mat^.data.ptr := nil;
    // if( mat->refcount != NULL && --*mat->refcount == 0 )
    if Assigned(mat^.refcount) then
    begin
      Dec(mat^.refcount^);
      if (mat^.refcount^ = 0) then
      begin
        cvFree(mat^.refcount);
        mat^.refcount := nil;
      end;
    end;
  end
  else if CV_IS_MATND(arr) then
  begin
    // CvMatND* mat = (CvMatND*)arr;
    matND := arr;
    // mat->data.ptr = NULL;
    matND^.data.ptr := nil;
    // if( mat->refcount != NULL && --*mat->refcount == 0 )
    if Assigned(matND^.refcount) then
    begin
      Dec(matND^.refcount^);
      if (matND^.refcount^ = 0) then
      begin
        cvFree(matND^.refcount);
        matND^.refcount := nil;
      end;
    end;
  end;
end;

function cvIncRefData(arr: pCvArr): Integer; inline;
Var
  mat: pCvMat;
  matND: pCvMatND;
begin
  result := 0;
  if CV_IS_MAT(arr) then
  begin
    // CvMat* mat = (CvMat*)arr;
    mat := arr;
    // if( mat->refcount != NULL )
    // refcount = ++*mat->refcount;
    if Assigned(mat^.refcount) then
    begin
      Inc(mat^.refcount^);
      result := mat^.refcount^;
    end;
  end
  else if CV_IS_MATND(arr) then
  begin
    // CvMatND* mat = (CvMatND*)arr;
    matND := arr;
    // if( mat->refcount != NULL )
    // refcount = ++*mat->refcount;
    if Assigned(matND^.refcount) then
    begin
      Inc(matND^.refcount^);
      result := matND^.refcount^;
    end;
  end;
end;

(* procedure cvCvtPixToPlane(const src: pCvArr; dst0: pCvArr; dst1: pCvArr; dst2: pCvArr; dst3: pCvArr); cdecl; external core_lib name 'cvSplit' {$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)
(* procedure cvCvtPlaneToPix(const src0: pCvArr; const src1: pCvArr; const src2: pCvArr; const src3: pCvArr; dst: pCvArr); cdecl; external core_lib name 'cvMerge' {$IFDEF DELAYEDLOADLIB} delayed{$ENDIF}; *)

var
  Path: string;
initialization
  Path := GetCurrentDir;
  {$IFDEF UNIX}
  SetCurrentDir(ExtractFilePath(ParamStr(0)));
  {$ELSE}
  SetCurrentDir(ExtractFilePath(ParamStr(0)) + CoreLibName);
  {$ENDIF}
  CoreLibHandle := LoadLibrary(CoreLibName);
  SetCurrentDir(Path);
  if CoreLibHandle <> 0 then Initialize(CoreLibHandle, False);

finalization
  if CoreLibHandle <> 0 then
     FreeLibrary(CoreLibHandle);

end.
