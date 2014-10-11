package com.game.artifact.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import flash.display.*;
    import flash.text.*;

    public class ArtifactAttrPreviewView extends Component
    {
        private var textField:TextField;
        private var upMark:DisplayObject;

        public function ArtifactAttrPreviewView()
        {
            super("artifactAttrPreviewView");
            this.textField = getDisplayChildByName("textField");
            this.upMark = getDisplayChildByName("upMark");
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this.textField.text = param1;
            this.upMark.visible = param1 != LanguageCfgObj.getInstance().getByIndex("10212");
            return;
        }// end function

    }
}
