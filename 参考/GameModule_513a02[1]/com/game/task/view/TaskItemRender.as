package com.game.task.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.game.task.model.*;
    import com.game.team.view.*;
    import flash.display.*;
    import flash.text.*;

    public class TaskItemRender extends ListItemBase implements IItem
    {
        private var _label:TextField;
        private var _date:TaskMsgVO;

        public function TaskItemRender(param1 = null, param2:String = null)
        {
            super("TaskListItemRender");
            return;
        }// end function

        override protected function getComp() : void
        {
            mcBack = _content.getChildByName("bg") as MovieClip;
            this._label = _content.getChildByName("label") as TextField;
            if (this._date)
            {
                this._label.htmlText = this._date.label;
            }
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            var _loc_2:* = this._date.conf.q_name;
            if (param1 == COLOR_NORMAL)
            {
                if (this._date.complete)
                {
                    _loc_2 = _loc_2 + ("<font color=\'#cccccc\'>" + LanguageCfgObj.getInstance().getByIndex("12234") + "</font>");
                }
                else
                {
                    _loc_2 = _loc_2 + ("<font color=\'#00ff00\'>" + LanguageCfgObj.getInstance().getByIndex("12252") + "</font>");
                }
                this.setText(_loc_2);
            }
            else
            {
                this._label.textColor = param1;
            }
            return;
        }// end function

        public function setText(param1:String) : void
        {
            this._label.htmlText = param1;
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return this._date;
        }// end function

        public function set obj(param1) : void
        {
            var _loc_2:* = null;
            this._date = param1;
            if (this._label)
            {
                _loc_2 = this._date.conf.q_name;
                if (this._date.complete)
                {
                    _loc_2 = _loc_2 + ("<font color=\'#cccccc\'>" + LanguageCfgObj.getInstance().getByIndex("12234") + "</font>");
                }
                else
                {
                    _loc_2 = _loc_2 + ("<font color=\'#00ff00\'>" + LanguageCfgObj.getInstance().getByIndex("12252") + "</font>");
                }
                this.setText(_loc_2);
            }
            return;
        }// end function

        public function get label() : String
        {
            return this._label.text;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            selected = param1;
            return;
        }// end function

    }
}
