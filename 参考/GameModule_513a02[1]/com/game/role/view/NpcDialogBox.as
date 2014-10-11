package com.game.role.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.role.control.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class NpcDialogBox extends BaseBox
    {
        private var closeBtn:BaseButton;
        public var txt_talker:TextField;
        public var txt_content:TextField;
        public var txt_npc_name:TextField;
        public var txt_label1:TextField;
        public var txt_label2:TextField;
        public var txt_label3:TextField;
        public var txt_label4:TextField;
        public var mc1:DisplayObject;
        public var mc2:DisplayObject;
        public var mc3:DisplayObject;
        public var mc4:DisplayObject;
        private var style:StyleSheet;
        private var html:String;
        private var _data:Object;

        public function NpcDialogBox()
        {
            loadDisplay("res/npcDialogBox.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("NpcDialogBox");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            this.txt_npc_name = getDisplayChildByName("txt_npc_name") as TextField;
            this.txt_npc_name.defaultTextFormat = new TextFormat(LanguageCfgObj.getInstance().getByIndex("11126"), 16, 16755200, true);
            this.txt_content = getDisplayChildByName("txt_content") as TextField;
            this.txt_talker = getDisplayChildByName("txt_talker") as TextField;
            this.txt_label1 = getDisplayChildByName("txt_label1") as TextField;
            this.txt_label2 = getDisplayChildByName("txt_label2") as TextField;
            this.txt_label3 = getDisplayChildByName("txt_label3") as TextField;
            this.txt_label4 = getDisplayChildByName("txt_label4") as TextField;
            this.style = new StyleSheet();
            this.style.parseCSS("a:hover { color:#dac53b; },  a:active {color:#cccccc;}");
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.mc3 = getDisplayChildByName("mc3");
            this.mc4 = getDisplayChildByName("mc4");
            this.setLabelListener(this.txt_label1, this.mc1);
            this.setLabelListener(this.txt_label2, this.mc2);
            this.setLabelListener(this.txt_label3, this.mc3);
            this.setLabelListener(this.txt_label4, this.mc4);
            if (this._data)
            {
                this.data = this._data;
            }
            return;
        }// end function

        public function setLabelListener(param1:TextField, param2:DisplayObject) : void
        {
            param1.styleSheet = this.style;
            param2.visible = false;
            param1.addEventListener(TextEvent.LINK, this.onTalkOverHandle);
            param1.addEventListener(MouseEvent.ROLL_OVER, this.onRollOverHandle);
            param1.addEventListener(MouseEvent.ROLL_OUT, this.onRollOutHandle);
            return;
        }// end function

        private function onRollOverHandle(event:MouseEvent) : void
        {
            (event.currentTarget.y - 1);
            var _loc_2:* = event.currentTarget as TextField;
            this.html = _loc_2.htmlText;
            _loc_2.htmlText = _loc_2.htmlText.replace(/<u>|<U>|<\/u>|<\/u>/g, "");
            return;
        }// end function

        private function onRollOutHandle(event:MouseEvent) : void
        {
            (event.currentTarget.y + 1);
            var _loc_2:* = event.currentTarget as TextField;
            _loc_2.htmlText = this.html;
            return;
        }// end function

        private function onTalkOverHandle(event:TextEvent) : void
        {
            NpcDialogControl.getInstance().parseLink(event);
            this.__close();
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            this._data = param1;
            if (this.txt_content)
            {
                this.txt_npc_name.text = this._data.title;
                this.txt_talker.text = this._data.talker + "：";
                this.txt_content.htmlText = this._data.content;
                this.setText(this.txt_label1, this._data.label1, this.mc1);
                this.setText(this.txt_label2, this._data.label2, this.mc2);
                this.setText(this.txt_label3, this._data.label3, this.mc3);
                this.setText(this.txt_label4, this._data.label4, this.mc4);
            }
            return;
        }// end function

        private function setText(param1:TextField, param2:String, param3:DisplayObject) : void
        {
            param1.htmlText = param2 ? (param2) : ("");
            param3.visible = Boolean(param2);
            param1.width = param1.textWidth + 6;
            param1.x = 160 - param1.textWidth * 0.5;
            param3.x = param1.x - 18;
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
