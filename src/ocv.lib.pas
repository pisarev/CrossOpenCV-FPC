(*
  **************************************************************************************************
  Project Delphi-OpenCV
  **************************************************************************************************
  Contributor:
  Laentir Valetov
  email:laex@bk.ru
  Mikhail Grigorev
  email:sleuthhound@gmail.com
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

*)

unit ocv.lib;

{$I OpenCV.inc}

interface

const
  CV_VERSION_EPOCH    = '2';
  CV_VERSION_MAJOR    = '4';
  CV_VERSION_MINOR    = '13';
  CV_VERSION_REVISION = '6';
  CV_VERSION = CV_VERSION_EPOCH + '.' + CV_VERSION_MAJOR + '.' + CV_VERSION_MINOR + '.' + CV_VERSION_REVISION;

  // * old  style version constants*/
  CV_MAJOR_VERSION    = CV_VERSION_EPOCH;
  CV_MINOR_VERSION    = CV_VERSION_MAJOR;
  CV_SUBMINOR_VERSION = CV_VERSION_MINOR;

  CV_VERSION_DLL = CV_VERSION_EPOCH + CV_VERSION_MAJOR + CV_VERSION_MINOR;

{$IFDEF MSWINDOWS}
  {$IFDEF NO_LOCAL_OPENCV2413}
    CV_DLL_DIR = '';
  {$ELSE}
    CV_DLL_DIR = '.\opencv_2.4.13\';
  {$ENDIF}
{$ELSE}
  {$IFDEF NO_LOCAL_OPENCV2413}
    CV_DLL_DIR = '';
  {$ELSE}
    CV_DLL_DIR = './bin/opencv_2.4.13/';
  {$ENDIF}
{$ENDIF}
// -------------------------------
  core_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_core' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_core.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_core.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_core.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  highgui_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_highgui' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_highgui.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_highgui.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_highgui.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  features2d_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_features2d' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_features2d.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_features2d.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_features2d.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  imgproc_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_imgproc' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_imgproc.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_imgproc.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_imgproc.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  objdetect_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_objdetect' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_objdetect.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_objdetect.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_objdetect.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  legacy_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_legacy' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_legacy.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_legacy.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_legacy.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  calib3d_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_calib3d' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_calib3d.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_calib3d.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_calib3d.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  tracking_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_video' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_video.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_video.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_video.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  nonfree_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_nonfree' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_nonfree.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_nonfree.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_nonfree.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  opencv_classes_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_classes' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_classes.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_classes.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_classes.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  opencv_photo_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_photo' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_photo.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_photo.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_photo.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
  opencv_contrib_lib =
{$IFDEF MSWINDOWS}
  CV_DLL_DIR + 'opencv_contrib' + CV_VERSION_DLL {$IFDEF DEBUG} + 'd'{$ENDIF} + '.dll';
{$ELSE}
{$IFDEF MACOS}
  CV_DLL_DIR + 'opencv_contrib.dylib';
{$ELSE}
{$IFDEF ANDROID}
  CV_DLL_DIR + 'libopencv_contrib.so';
{$ELSE}
  CV_DLL_DIR + 'libopencv_contrib.so';
{$ENDIF}
{$ENDIF}
{$ENDIF}
// -------------------------------
//
//
// -------------------------------
//

implementation

end.
