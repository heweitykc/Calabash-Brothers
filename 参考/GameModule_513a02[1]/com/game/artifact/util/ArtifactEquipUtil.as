package com.game.artifact.util
{
    import com.cfg.obj.*;
    import com.model.vo.*;

    public class ArtifactEquipUtil extends Object
    {
        private static var zhuoyueAttributeIds:Array;

        public function ArtifactEquipUtil()
        {
            return;
        }// end function

        public static function getZhuoyueAttributeIds() : Array
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (zhuoyueAttributeIds == null)
            {
                _loc_1 = GlobalCfgObj.getInstance().getRemark();
                _loc_1 = _loc_1.slice(1, (_loc_1.length - 1));
                zhuoyueAttributeIds = _loc_1.split(",");
                _loc_2 = 0;
                while (_loc_2 < zhuoyueAttributeIds.length)
                {
                    
                    zhuoyueAttributeIds[_loc_2] = int(zhuoyueAttributeIds[_loc_2]);
                    _loc_2 = _loc_2 + 1;
                }
            }
            return zhuoyueAttributeIds;
        }// end function

        public static function getEquipZhuoyueNum(param1:EquipmentInfo) : int
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            for each (_loc_3 in getZhuoyueAttributeIds())
            {
                
                _loc_4 = Attributes.getAttrNameByType(_loc_3);
                if (hasEquipAttribute(param1, _loc_3))
                {
                    _loc_2++;
                }
            }
            return _loc_2;
        }// end function

        public static function hasEquipAttribute(param1:EquipmentInfo, param2:int) : Boolean
        {
            var _loc_3:* = Attributes.getAttrNameByType(param2);
            return _loc_3 && param1[_loc_3];
        }// end function

    }
}
