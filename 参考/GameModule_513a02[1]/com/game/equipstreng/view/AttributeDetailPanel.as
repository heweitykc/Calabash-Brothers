package com.game.equipstreng.view
{
    import com.f1.ui.*;
    import flash.display.*;
    import flash.text.*;

    public class AttributeDetailPanel extends Component
    {
        private var txt_attr1:TextField;
        private var txt_attr2:TextField;
        private var txt_attr3:TextField;
        private var txt_attr4:TextField;
        private var txtBg1:MovieClip;
        private var txtBg2:MovieClip;
        private var txtBg3:MovieClip;
        private var txtBg4:MovieClip;
        private var icon1:MovieClip;
        private var icon2:MovieClip;
        private var icon3:MovieClip;
        private var icon4:MovieClip;
        private var txt_attrVal1:TextField;
        private var txt_attrVal2:TextField;
        private var txt_attrVal3:TextField;
        private var txt_attrVal4:TextField;
        private var txt_attrValAdd1:TextField;
        private var txt_attrValAdd2:TextField;
        private var txt_attrValAdd3:TextField;
        private var txt_attrValAdd4:TextField;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;

        public function AttributeDetailPanel(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.txt_attr1 = getDisplayChildByName("txt_attr1");
            this.txt_attr2 = getDisplayChildByName("txt_attr2");
            this.txt_attr3 = getDisplayChildByName("txt_attr3");
            this.txt_attr4 = getDisplayChildByName("txt_attr4");
            this.txtBg1 = getDisplayChildByName("txtBg1");
            this.txtBg2 = getDisplayChildByName("txtBg2");
            this.txtBg3 = getDisplayChildByName("txtBg3");
            this.txtBg4 = getDisplayChildByName("txtBg4");
            this.icon1 = getDisplayChildByName("icon1");
            this.icon2 = getDisplayChildByName("icon2");
            this.icon3 = getDisplayChildByName("icon3");
            this.icon4 = getDisplayChildByName("icon4");
            this.txt_attrVal1 = getDisplayChildByName("txt_attrVal1");
            this.txt_attrVal2 = getDisplayChildByName("txt_attrVal2");
            this.txt_attrVal3 = getDisplayChildByName("txt_attrVal3");
            this.txt_attrVal4 = getDisplayChildByName("txt_attrVal4");
            this.txt_attrValAdd1 = getDisplayChildByName("txt_attrValAdd1");
            this.txt_attrValAdd2 = getDisplayChildByName("txt_attrValAdd2");
            this.txt_attrValAdd3 = getDisplayChildByName("txt_attrValAdd3");
            this.txt_attrValAdd4 = getDisplayChildByName("txt_attrValAdd4");
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.mc3 = getDisplayChildByName("mc3");
            this.mc4 = getDisplayChildByName("mc4");
            return;
        }// end function

        public function setAttribute(param1:Array, param2:Array, param3:Boolean) : void
        {
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                if (param3 || param2[_loc_4] > 0)
                {
                    this["txt_attr" + (_loc_4 + 1)].htmlText = param1[_loc_4];
                    this["txt_attrValAdd" + (_loc_4 + 1)].htmlText = (param2[_loc_4] > 0 ? ("+") : ("")) + param2[_loc_4];
                    this["mc" + (_loc_4 + 1)].visible = true;
                    this["txtBg" + (_loc_4 + 1)].visible = true;
                    this["icon" + (_loc_4 + 1)].visible = true;
                }
                else
                {
                    this["txt_attr" + (_loc_4 + 1)].htmlText = "";
                    this["txt_attrValAdd" + (_loc_4 + 1)].htmlText = "";
                    this["mc" + (_loc_4 + 1)].visible = false;
                    this["txtBg" + (_loc_4 + 1)].visible = false;
                    this["icon" + (_loc_4 + 1)].visible = false;
                }
                _loc_4++;
            }
            var _loc_5:* = _loc_4;
            while (_loc_5 < 4)
            {
                
                this["txt_attr" + (_loc_5 + 1)].htmlText = "";
                this["txt_attrValAdd" + (_loc_5 + 1)].htmlText = "";
                this["mc" + (_loc_5 + 1)].visible = false;
                this["txtBg" + (_loc_5 + 1)].visible = false;
                this["icon" + (_loc_5 + 1)].visible = false;
                _loc_5++;
            }
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < 4)
            {
                
                this["txt_attr" + (_loc_1 + 1)].text = "";
                this["txt_attrValAdd" + (_loc_1 + 1)].text = "";
                this["mc" + (_loc_1 + 1)].visible = false;
                this["txtBg" + (_loc_1 + 1)].visible = false;
                this["icon" + (_loc_1 + 1)].visible = false;
                _loc_1++;
            }
            return;
        }// end function

    }
}
