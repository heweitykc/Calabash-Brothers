package com.model.vo
{
    import com.cfg.vo.*;
    import com.f1.*;
    import com.game.utils.*;
    import com.staticdata.*;
    import com.util.*;

    public class ElementHeartInfo extends QEheart
    {
        public var effectUrl:String = "art/res/eheart/ys0001.png";
        public var desc:String = "愤怒的元素之心 Lv.4<br/>品质 白色<br/>经验 0/6000 <br/>属性加成以及值";
        public var index:int;
        public var eheartId:long;
        public var exp:int;
        public var lock:int;

        public function ElementHeartInfo()
        {
            return;
        }// end function

        override public function parse(param1:Object) : void
        {
            super.parse(param1);
            this.effectUrl = "art/res/eheart/" + q_resourse + ".png";
            return;
        }// end function

        public function get color() : String
        {
            return PropUtil.getElementColor(Math.abs(q_quality)).toString(16);
        }// end function

        public function getAttrTips() : String
        {
            var _loc_1:* = null;
            if (q_attr_type == ElementType.SHANGDOU || q_attr_type == ElementType.JIAN_SHOU || q_attr_type == ElementType.JIAN_REN || q_attr_type == ElementType.GAO_GUI || q_attr_type == ElementType.QIANG_GONG || q_attr_type == ElementType.BU_QU)
            {
                _loc_1 = q_attr_value.toString();
            }
            else
            {
                _loc_1 = q_attr_value / 100 + "%";
            }
            return LanguageCfgObj.getInstance().getByIndex("ehattr" + q_attr_type, "lang_elementHeart") + _loc_1;
        }// end function

        public function isExpDan() : Boolean
        {
            if (q_quality < 0)
            {
                return true;
            }
            return false;
        }// end function

    }
}
