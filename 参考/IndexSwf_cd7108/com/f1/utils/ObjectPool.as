package com.f1.utils
{
    import com.f1.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;

    public class ObjectPool extends Object
    {
        private static var classInstances:Dictionary = new Dictionary(false);

        public function ObjectPool()
        {
            return;
        }// end function

        public static function CheckOut(param1:Class)
        {
            if (!ObjectPool.classInstances[param1])
            {
                ObjectPool.classInstances[param1] = new Array();
            }
            var _loc_2:* = ObjectPool.classInstances[param1];
            if (_loc_2.length == 0)
            {
                _loc_2.push(new param1);
            }
            var _loc_3:* = _loc_2.pop();
            if (_loc_3 is MovieClip)
            {
                (_loc_3 as MovieClip).gotoAndPlay(1);
            }
            return _loc_3;
        }// end function

        public static function CheckOutByName(param1:String)
        {
            var _loc_2:* = ToolKit.reflection(param1);
            if (_loc_2)
            {
                return CheckOut(_loc_2);
            }
            return null;
        }// end function

        public static function clearAll() : void
        {
            classInstances = new Dictionary(false);
            return;
        }// end function

        public static function CheckIn(param1) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (!param1)
            {
                return;
            }
            var _loc_2:* = param1.constructor;
            if (param1 is BaseSprite)
            {
                if (param1.hasOwnProperty("reset"))
                {
                    _loc_4 = param1["reset"];
                    if (_loc_4 != null)
                    {
                        _loc_4.call(null);
                    }
                }
            }
            if (param1 is MovieClip)
            {
                _loc_5 = param1 as MovieClip;
                if (_loc_5)
                {
                    _loc_5.gotoAndStop(1);
                }
            }
            if (param1 is Sprite)
            {
                _loc_6 = param1 as Sprite;
                _loc_6.graphics.clear();
            }
            if (param1 is Shape)
            {
                _loc_7 = param1 as Shape;
                _loc_7.graphics.clear();
            }
            if (param1 is DisplayObject)
            {
                _loc_8 = param1 as DisplayObject;
                _loc_8.x = 0;
                _loc_8.y = 0;
                _loc_8.alpha = 1;
                _loc_8.blendMode = BlendMode.NORMAL;
                _loc_8.cacheAsBitmap = false;
                _loc_8.filters = [];
                _loc_8.mask = null;
                _loc_8.rotation = 0;
                _loc_8.scaleX = 1;
                _loc_8.scaleY = 1;
                _loc_8.scrollRect = null;
                _loc_8.visible = true;
                _loc_8.transform.matrix = new Matrix();
                _loc_8.transform.colorTransform = new ColorTransform();
            }
            if (!ObjectPool.classInstances[_loc_2])
            {
                ObjectPool.classInstances[_loc_2] = new Array();
            }
            var _loc_3:* = ObjectPool.classInstances[_loc_2];
            _loc_3.push(param1);
            return;
        }// end function

        public static function removes(param1:Class = null, param2:Boolean = false) : void
        {
            var _loc_3:* = undefined;
            if (param1)
            {
                ObjectPool.classInstances[param1] = null;
            }
            else
            {
                for (_loc_3 in ObjectPool.classInstances)
                {
                    
                    _loc_5[_loc_3] = null;
                }
            }
            if (param2)
            {
                ObjectPool.garbageCollect();
            }
            return;
        }// end function

        public static function garbageCollect() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            Log.log("强制回收GC========================================");
            try
            {
                _loc_1 = new LocalConnection();
                _loc_2 = new LocalConnection();
                _loc_1.connect("name");
                _loc_2.connect("name");
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
