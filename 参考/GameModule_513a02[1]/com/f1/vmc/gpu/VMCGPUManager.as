package com.f1.vmc.gpu
{
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import flash.utils.*;
    import starling.textures.*;

    public class VMCGPUManager extends Object
    {
        private static var loaders:Dictionary = new Dictionary();

        public function VMCGPUManager()
        {
            return;
        }// end function

        public static function addKeep(param1:String) : void
        {
            var _loc_2:* = loaders[param1];
            if (_loc_2)
            {
                _loc_2.keep = true;
            }
            return;
        }// end function

        public static function clearRes() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            Log.log("VMCManager clearRes");
            var _loc_1:* = [];
            for each (_loc_2 in loaders)
            {
                
                if (!_loc_2.keep)
                {
                    _loc_2.finalize();
                    _loc_1.push(_loc_2.url);
                }
            }
            for each (_loc_3 in _loc_1)
            {
                
                loaders[_loc_3] = null;
                delete loaders[_loc_3];
            }
            return;
        }// end function

        public static function removeCallBack(param1:String, param2:Function, param3:Function = null, param4:Function = null) : void
        {
            var _loc_5:* = loaders[param1];
            if (loaders[param1])
            {
                if (_loc_5.loading)
                {
                    _loc_5.removeCallBack(param2, param3, param4);
                }
            }
            return;
        }// end function

        public static function getTexture(param1:String) : Texture
        {
            var _loc_2:* = loaders[param1];
            if (_loc_2)
            {
                return _loc_2.texture;
            }
            return null;
        }// end function

        public static function getImgRects(param1:String, param2:String) : Array
        {
            var _loc_3:* = loaders[param1];
            if (_loc_3)
            {
                return _loc_3.bmds[param2];
            }
            return null;
        }// end function

        public static function isLoaded(param1:String) : Boolean
        {
            return loaders[param1] && VMCGPULoader(loaders[param1]).loaded;
        }// end function

        public static function isLoading(param1:String) : Boolean
        {
            return loaders[param1] && VMCGPULoader(loaders[param1]).loading;
        }// end function

        public static function getPoseInfo(param1:String, param2:String = "90") : PoseInfo
        {
            if (!param1)
            {
                return null;
            }
            var _loc_3:* = loaders[param1];
            if (_loc_3)
            {
                if (_loc_3.loaded)
                {
                    return _loc_3.getPoseInfo(param2);
                }
            }
            return null;
        }// end function

        public static function addRes(param1:String, param2:Function = null, param3:Array = null, param4:Function = null, param5:Function = null, param6:Boolean = false, param7:int = 0) : Boolean
        {
            if (!param1)
            {
                return false;
            }
            var _loc_8:* = loaders[param1];
            if (loaders[param1])
            {
                _loc_8.keep = param6;
                if (_loc_8.loaded)
                {
                    doCompleteCallBack(param2, param3);
                    return false;
                }
                _loc_8.addCallBack(param2, param3, param4, param5);
                if (_loc_8.loading)
                {
                    return true;
                }
            }
            else
            {
                _loc_8 = new VMCGPULoader(param2, param3, param4, param5);
                _loc_8.keep = param6;
                loaders[param1] = _loc_8;
            }
            _loc_8.loadRes(param1, param7);
            return true;
        }// end function

        private static function doCompleteCallBack(param1:Function, param2:Array) : void
        {
            if (param1 != null)
            {
                if (param2 == null)
                {
                    param1.apply(null);
                }
                else
                {
                    param1.apply(null, param2);
                }
            }
            return;
        }// end function

    }
}
