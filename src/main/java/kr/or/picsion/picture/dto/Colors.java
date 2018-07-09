/**
 * 
 */
package kr.or.picsion.picture.dto;

/**
 * @author Bit
 *
 */
public class Colors {
	
	private int colorR;
	private int colorG;
	private int colorB;
	
	public Colors() {}
	
	public Colors(int colorR, int colorG, int colorB) {
		super();
		this.colorR = colorR;
		this.colorG = colorG;
		this.colorB = colorB;
	}


	public int getColorR() {
		return colorR;
	}

	public void setColorR(int colorR) {
		this.colorR = colorR;
	}

	public int getColorG() {
		return colorG;
	}

	public void setColorG(int colorG) {
		this.colorG = colorG;
	}

	public int getColorB() {
		return colorB;
	}

	public void setColorB(int colorB) {
		this.colorB = colorB;
	}
	
}
