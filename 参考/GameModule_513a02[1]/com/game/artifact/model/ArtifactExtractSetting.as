package com.game.artifact.model
{
    import com.game.artifact.util.*;
    import com.game.backpack.util.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class ArtifactExtractSetting extends Object
    {
        public var jobType:uint;
        public var maxAppend:uint = 1;
        public var maxIntensify:uint = 1;
        public var maxSteplv:uint = 1;
        public var maxZhuoyueNum:uint = 1;
        public var allowScoreHigher:Boolean = false;
        public var allowMaya:Boolean = false;
        public var allowAutoExtract:Boolean = false;
        public static var JOB_TYPE_ALL:uint = 1;
        public static var JOB_TYPE_OTHER:uint = 2;
        public static var JOB_TYPE_MY:uint = 3;
        private static var fieldSep:String = ",";
        private static var keyValueSep:String = ":";
        private static var FIELD_jobType:ArtifactExtractSettingField = new ArtifactExtractSettingField(1, "jobType", ArtifactExtractSettingFieldType.UINT);
        private static var FIELD_maxAppend:ArtifactExtractSettingField = new ArtifactExtractSettingField(2, "maxAppend", ArtifactExtractSettingFieldType.UINT);
        private static var FIELD_maxIntensify:ArtifactExtractSettingField = new ArtifactExtractSettingField(3, "maxIntensify", ArtifactExtractSettingFieldType.UINT);
        private static var FIELD_maxSteplv:ArtifactExtractSettingField = new ArtifactExtractSettingField(4, "maxSteplv", ArtifactExtractSettingFieldType.UINT);
        private static var FIELD_allowScoreHigher:ArtifactExtractSettingField = new ArtifactExtractSettingField(5, "allowScoreHigher", ArtifactExtractSettingFieldType.BOOLEAN);
        private static var FIELD_allowMaya:ArtifactExtractSettingField = new ArtifactExtractSettingField(6, "allowMaya", ArtifactExtractSettingFieldType.BOOLEAN);
        private static var FIELD_maxZhuoyueNum:ArtifactExtractSettingField = new ArtifactExtractSettingField(8, "maxZhuoyueNum", ArtifactExtractSettingFieldType.UINT);
        private static var fields:Array = [FIELD_jobType, FIELD_maxAppend, FIELD_maxIntensify, FIELD_maxSteplv, FIELD_allowScoreHigher, FIELD_allowMaya, FIELD_maxZhuoyueNum];
        private static var fieldDict:Dictionary = new Dictionary();

        public function ArtifactExtractSetting()
        {
            this.jobType = JOB_TYPE_ALL;
            return;
        }// end function

        public function updateData(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (param1 == null || param1.length == 0)
            {
                return;
            }
            var _loc_2:* = param1.split(fieldSep);
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.length > 0)
                {
                    _loc_4 = _loc_3.split(keyValueSep);
                    _loc_5 = _loc_4[0];
                    _loc_6 = _loc_4[1];
                    _loc_7 = fieldDict[_loc_5];
                    if (_loc_7 != null)
                    {
                        _loc_7.setValue(this, _loc_6);
                    }
                }
            }
            return;
        }// end function

        public function valueToString() : String
        {
            var _loc_2:* = null;
            var _loc_1:* = "";
            for each (_loc_2 in fields)
            {
                
                if (_loc_1.length > 0)
                {
                    _loc_1 = _loc_1 + fieldSep;
                }
                _loc_1 = _loc_1 + (_loc_2.id + keyValueSep + _loc_2.getValue(this));
            }
            return _loc_1;
        }// end function

        public function allowItem(param1:PropInfo) : Boolean
        {
            if (param1.itemModelId == ArtifactConst.tiliandanItemModelId)
            {
                return true;
            }
            if (param1.itemModelId == ArtifactConst.mayaItemModelId)
            {
                return this.allowMaya;
            }
            return this.allowEquip(param1 as EquipmentInfo);
        }// end function

        private function allowEquip(param1:EquipmentInfo) : Boolean
        {
            switch(this.jobType)
            {
                case JOB_TYPE_MY:
                {
                    if (!isUseForMyJob(param1))
                    {
                        return false;
                    }
                    break;
                }
                case JOB_TYPE_OTHER:
                {
                    if (isUseForMyJob(param1))
                    {
                        return false;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this.maxAppend != 0)
            {
                if (param1.addAttributLevel > this.maxAppend)
                {
                    return false;
                }
            }
            if (this.maxIntensify != 0)
            {
                if (param1.intensify > this.maxIntensify)
                {
                    return false;
                }
            }
            if (this.maxSteplv != 0)
            {
                if (param1.q_equip_steplv > this.maxSteplv)
                {
                    return false;
                }
            }
            if (this.maxZhuoyueNum != 0)
            {
                if (ArtifactEquipUtil.getEquipZhuoyueNum(param1) > this.maxZhuoyueNum)
                {
                    return false;
                }
            }
            if (!this.allowScoreHigher)
            {
                if (EquipUtil.compareEquip(param1) == 1)
                {
                    return false;
                }
            }
            return true;
        }// end function

        private static function initClass() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in fields)
            {
                
                fieldDict[_loc_1.id] = _loc_1;
            }
            return;
        }// end function

        private static function isUseForMyJob(param1:EquipmentInfo) : Boolean
        {
            return param1.isUseForJobKind(UserObj.getInstance().playerInfo.jobkind);
        }// end function

        initClass();
    }
}
