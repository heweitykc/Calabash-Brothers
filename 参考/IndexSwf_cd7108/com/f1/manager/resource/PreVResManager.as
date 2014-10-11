package com.f1.manager.resource
{
    import com.f1.*;
    import flash.utils.*;

    public class PreVResManager extends BaseEventDispatcher
    {
        public static const PRE_STRENTH:uint = 5;
        public static const PRE_FIREDRAGON:uint = 1;
        public static const PRE_REGITE:int = -1;
        private static var _preLoaders:Dictionary = new Dictionary();
        private static var _config:Object;

        public function PreVResManager()
        {
            return;
        }// end function

        public static function add(param1:int, param2, param3:int = 1) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = new LoaderObj();
            if (param2 is String)
            {
                _loc_5 = param2;
                _loc_5 = (_loc_5 as String).replace(/\"|\n|\t| /g, "");
                _loc_4.priority = param3;
                _loc_4.resourcesGroup = _loc_5.split(",");
                addToPreDictionary(param1, _loc_4);
            }
            else if (param2 is Array)
            {
                _loc_4.priority = param3;
                _loc_4.resourcesGroup = param2;
                addToPreDictionary(param1, _loc_4);
            }
            return;
        }// end function

        public static function load(param1:int, param2:Function = null, param3:Function = null, param4:Array = null, param5:Array = null) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_6:* = _preLoaders[param1];
            if (_preLoaders[param1] && _loc_6.resourcesGroup)
            {
                _loc_7 = param5 ? (_loc_6.resourcesGroup.concat(param5)) : (_loc_6.resourcesGroup);
                _loc_8 = [];
                _loc_9 = [];
                for each (_loc_10 in _loc_7)
                {
                    
                    _loc_11 = getFileType(_loc_10);
                    if (_loc_11 == "png" || _loc_11 == "jpg")
                    {
                        _loc_8.push(_loc_10);
                        continue;
                    }
                    _loc_9.push(_loc_10);
                }
                VResManager.loadGroup(_loc_9, null, null, null, param2, param3, param4, false, false, true, 0, _loc_6.priority);
                VResManager.loadGroup(_loc_8, null, null, null, param2, param3, param4, false, true, true, 0, _loc_6.priority);
            }
            return;
        }// end function

        private static function getFileType(param1:String) : String
        {
            var _loc_2:* = param1.split(".");
            return _loc_2[(_loc_2.length - 1)].split("?")[0];
        }// end function

        public static function release(param1:int) : void
        {
            deleteDictionary(param1);
            return;
        }// end function

        private static function addToPreDictionary(param1:int, param2:LoaderObj) : void
        {
            _preLoaders[param1] = param2;
            return;
        }// end function

        private static function deleteDictionary(param1:int) : void
        {
            delete _preLoaders[param1];
            return;
        }// end function

        public static function initCofig(param1:Object, param2:uint) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            _config = param1;
            for (_loc_4 in param1)
            {
                
                _loc_3 = uint(_loc_4);
                if (_loc_3 > 0 && (_loc_6[_loc_3].q_job == 0 || _loc_6[_loc_3].q_job == param2))
                {
                    add(_loc_6[_loc_3].q_group_id, _loc_6[_loc_3].q_resource, _loc_6[_loc_3].q_priority);
                }
            }
            return;
        }// end function

        public static function loadbyLevel(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in _config)
            {
                
                if (_loc_2.q_upload_type == 1 && _loc_2.q_level_trigger != -1 && _loc_2.q_level_trigger <= param1 && param1 < _loc_2.q_level_limit)
                {
                    load(_loc_2.q_group_id);
                }
            }
            return;
        }// end function

    }
}

import com.f1.*;

import flash.utils.*;

class LoaderObj extends Object
{
    public var priority:int = 1;
    public var resourcesGroup:Array;

    function LoaderObj()
    {
        return;
    }// end function

}

