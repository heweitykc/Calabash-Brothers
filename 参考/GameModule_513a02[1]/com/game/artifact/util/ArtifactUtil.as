package com.game.artifact.util
{

    public class ArtifactUtil extends Object
    {

        public function ArtifactUtil()
        {
            return;
        }// end function

        public static function getMapSize(param1:Object) : uint
        {
            var _loc_3:* = undefined;
            var _loc_2:* = 0;
            for (_loc_3 in param1)
            {
                
                _loc_2 = _loc_2 + 1;
            }
            return _loc_2;
        }// end function

        public static function newVector(param1, ... args)
        {
            args = undefined;
            for each (args in args)
            {
                
                param1.push(args);
            }
            return param1;
        }// end function

        public static function getInNestedDict(param1, param2, param3)
        {
            if (param1 == null)
            {
                return null;
            }
            var _loc_4:* = param1[param2];
            if (param1[param2] == null)
            {
                return null;
            }
            return _loc_4[param3];
        }// end function

        public static function toNumber(param1) : Number
        {
            return param1 == null ? (0) : (Number(param1));
        }// end function

    }
}
