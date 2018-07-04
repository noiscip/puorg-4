package kr.or.picsion.picture.dto;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.picture.dto 
 * @className Face
 * @date 2018. 6. 24.
 */

public class Face {
	
	private int x_0;
	private int x_1;
	private int y_1;
	private int y_2;
	private int width;
	private int height;
	
	
	public Face() {}
	
	public Face(int x_0, int x_1, int y_1, int y_2) {
		this.x_0 = x_0;
		this.x_1 = x_1;
		this.y_1 = y_1;
		this.y_2 = y_2;
		this.width = x_1-x_0;
		this.height = y_2-y_1;
	}
	public int getX_0() {
		return x_0;
	}
	public void setX_0(int x_0) {
		this.x_0 = x_0;
	}
	public int getX_1() {
		return x_1;
	}
	public void setX_1(int x_1) {
		this.x_1 = x_1;
	}
	public int getY_1() {
		return y_1;
	}
	public void setY_1(int y_1) {
		this.y_1 = y_1;
	}
	public int getY_2() {
		return y_2;
	}
	public void setY_2(int y_2) {
		this.y_2 = y_2;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	
	
	
	
	

}
