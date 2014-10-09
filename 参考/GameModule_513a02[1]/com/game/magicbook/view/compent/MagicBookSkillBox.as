package com.game.magicbook.view.compent
{
    import com.game.operationpanel.view.*;
    import com.model.vo.*;
    import com.view.tipcell.*;

    public class MagicBookSkillBox extends SkillBox
    {
        private var _magicinfo:MagicBookSkillInfo;

        public function MagicBookSkillBox(param1:String = "magicBook_skilllock")
        {
            super(param1);
            return;
        }// end function

        public function setInfo(param1) : void
        {
            var info:* = param1;
            this._magicinfo = info as MagicBookSkillInfo;
            if (this._magicinfo)
            {
                _image.load(this._magicinfo.iconUrl, function () : void
            {
                _image.setSize(_widthImg - 10, _heightImg - 10);
                return;
            }// end function
            );
            }
            else
            {
                ItemTips.dispose(this);
            }
            ItemTips.create(this, this._magicinfo, SkillTips);
            return;
        }// end function

    }
}
