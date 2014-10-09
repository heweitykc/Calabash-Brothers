package com.game.equipstreng.control
{
    import com.*;
    import com.game.equipstreng.view.*;

    public class EquipComposeControl extends Object
    {
        private var _equipComposeBox:EquipComposeBox;
        private var _composeEquipSelectBox:ComposeEquipSelectBox;
        private static var _instance:EquipComposeControl;

        public function EquipComposeControl()
        {
            return;
        }// end function

        public function get equipComposeBox() : EquipComposeBox
        {
            return this._equipComposeBox;
        }// end function

        public function get composeEquipSelectBox() : ComposeEquipSelectBox
        {
            if (!this._composeEquipSelectBox)
            {
                this._composeEquipSelectBox = new ComposeEquipSelectBox();
                Global.popManager.addPop(this._composeEquipSelectBox, false, false, true, true, false, true);
            }
            return this._composeEquipSelectBox;
        }// end function

        public function openEquipComposeBox() : void
        {
            if (!this._equipComposeBox)
            {
                this._equipComposeBox = new EquipComposeBox();
                Global.popManager.addPop(this._equipComposeBox);
            }
            this._equipComposeBox.openOrClose();
            return;
        }// end function

        public function openOnlyEquipComposeBox(param1:String = null, param2:Boolean = false) : void
        {
            if (!this._equipComposeBox)
            {
                this._equipComposeBox = new EquipComposeBox();
                Global.popManager.addPop(this._equipComposeBox);
            }
            if (param1 != null)
            {
                this._equipComposeBox.selectItemByItemName(param1);
            }
            this._equipComposeBox.needAutoClick = param2;
            this._equipComposeBox.open();
            return;
        }// end function

        public function openEquipComposeEquipSelectBox(param1:int, param2:int = -1) : void
        {
            this.composeEquipSelectBox.type = param1;
            this.composeEquipSelectBox.phase = param2;
            this.composeEquipSelectBox.open();
            return;
        }// end function

        public static function getInstance() : EquipComposeControl
        {
            if (_instance == null)
            {
                _instance = new EquipComposeControl;
            }
            return _instance;
        }// end function

    }
}
