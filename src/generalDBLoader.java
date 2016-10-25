import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.Iterator;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class generalDBLoader {

	public static void main(String[] args) {
		String filePath = "testData0.2/";
		String dbURL = "jdbc:mysql://151.80.133.186:3306/oscar_t1";
		String user = "oscarac1";
		String password = "ATL_cSo_42_!%";

		xlsxToDB(filePath, "insertTestTable.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertCompany.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertSupplier.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertUser.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertCustomer.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertAddress.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertCategory.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertProduct.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertStock.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertDeliveryCompany.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertDeliveryMethod.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertPurchaseOrder.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertPOLine.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertSalesOrder.xlsx", 1, dbURL, user, password);
		xlsxToDB(filePath, "insertSOLine.xlsx", 1, dbURL, user, password);

		//System.out.println(procedureStrGenerator("insertTestTable.xlsx", 4));

	}

	private static void xlsxToDB(String filePath, String fileName, int rowStartOffset, String dbURL, String user,
			String password) {
		String fullPath;
		fullPath = filePath.concat(fileName);
		System.out.println(fullPath);
		
		String[][] dataArray = XlsxToRawArray(fullPath, 1, 0);
		
		System.out.println("dataArray[" + dataArray.length + "][" + dataArray[0].length + "]");

		Connection conn = null;
		ResultSet rs = null;
		CallableStatement cstm = null;

		try {
			conn = DriverManager.getConnection(dbURL, user, password);
			// cstm = conn.prepareCall(procedureSelector(fileName));
			cstm = conn.prepareCall(procedureStrGenerator(fileName, dataArray[0].length));

			for (int i = 0; i < dataArray.length; i++) {
				for (int j = 0; j < dataArray[i].length; j++) {
					cstm.setString(j + 1, dataArray[i][j]);
				}
				rs = cstm.executeQuery();
				System.out.println(i + " " + rs);
			}
			System.out.println("");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static String procedureStrGenerator(String fileName, int collumns) {
		String procedureReturnStr = "{CALL ";
		String[] tokens = fileName.split("\\.(?=[^\\.]+$)");
		procedureReturnStr = procedureReturnStr.concat(tokens[0]);

		for (int i = 0; i < collumns; i++) {
			if (i == 0) {
				procedureReturnStr = procedureReturnStr.concat("(?");
			} else {
				procedureReturnStr = procedureReturnStr.concat(",?");
			}
		}
		procedureReturnStr = procedureReturnStr.concat(")}");

		return procedureReturnStr;
	}

	private static String procedureSelector(String fileName) {
		String procedureStr = new String();

		switch (fileName) {
		case "insertTestTable.xlsx":
			procedureStr = "{CALL insertTestTable(?,?,?,?)}";
			break;
		case "insertCompany.xlsx":
			procedureStr = "{CALL insertCompany(?)}";
			break;
		case "insertSupplier.xlsx":
			procedureStr = "{CALL insertSupplier(?)}";
			break;
		case "insertUser.xlsx":
			procedureStr = "{CALL insertUser(?,?,?)}";
			break;
		case "insertCustomer.xlsx":
			procedureStr = "{CALL insertCustomer(?)}";
			break;
		case "insertAddress.xlsx":
			procedureStr = "{CALL insertAddress(?,?,?,?,?,?)}";
			break;
		case "insertCategory.xlsx":
			procedureStr = "{CALL insertCategory(?)}";
			break;
		case "insertProduct.xlsx":
			procedureStr = "{CALL insertProduct(?,?,?,?,?)}";
			break;
		case "insertStock.xlsx":
			procedureStr = "{CALL insertStock(?,?)}";
			break;
		case "insertDeliveryCompany.xlsx":
			procedureStr = "{CALL insertDeliveryCompany(?)}";
			break;
		case "insertDeliveryMethod.xlsx":
			procedureStr = "{CALL insertDeliveryMethod(?,?,?,?)}";
			break;
		case "insertPurchaseOrder.xlsx":
			procedureStr = "{CALL insertPurchaseOrder(?,?,?,?,?,?)}";
			break;
		case "insertPOLine.xlsx":
			procedureStr = "{CALL insertPOLine(?,?,?)}";
			break;
		case "insertSalesOrder.xlsx":
			procedureStr = "{CALL insertSalesOrder(?,?,?,?,?,?,?,?,?)}";
			break;
		case "insertSOLine.xlsx":
			procedureStr = "{CALL insertSOLine(?,?,?)}";
			break;

		default:
		}

		return procedureStr;
	}

	private static String[][] XlsxToRawArray(String xlsxFile, int rowStartOffset, int rowEndOffset) {

		String[][] xlsxRawArray = null;
		try {
			InputStream ExcelFileToRead = new FileInputStream(xlsxFile);
			XSSFWorkbook wb = new XSSFWorkbook(ExcelFileToRead);
			XSSFSheet sheet = wb.getSheetAt(0);
			XSSFRow row;
			XSSFCell cell;
			String value = "";
			Iterator rows = sheet.rowIterator();

			// Eliminate invalid offset-inputs
			if ((rowStartOffset + rowEndOffset) >= sheet.getPhysicalNumberOfRows() || rowStartOffset < 0
					|| rowEndOffset < 0) {
				System.out.println(
						"Illegal Row-Offsets\nRow-Offsets leave no physicalNumberOfRows to read OR\nRow-Offset < 0\nReturned String[0][0]");
				wb.close();
				ExcelFileToRead.close();
				return new String[0][0];
			}

			for (int i = 0; i < sheet.getPhysicalNumberOfRows() - rowEndOffset; i++) {
				row = (XSSFRow) rows.next();
				if (i < rowStartOffset) {
					continue;
				} else if (i == rowStartOffset) {
					xlsxRawArray = new String[sheet.getPhysicalNumberOfRows() - (rowStartOffset + rowEndOffset)][row
							.getLastCellNum()];
				}

				for (int j = 0; j < row.getLastCellNum(); j++) {
					cell = row.getCell(j, Row.CREATE_NULL_AS_BLANK);
					switch (cell.getCellType()) {
					case Cell.CELL_TYPE_STRING:
						value = new String(cell.getStringCellValue().getBytes(Charset.forName("UTF-8")), "UTF-8");
						break;
					case Cell.CELL_TYPE_NUMERIC:
						value = String.valueOf(cell.getNumericCellValue());
						break;
					case Cell.CELL_TYPE_BOOLEAN:
						value = String.valueOf(cell.getBooleanCellValue());
						break;
					case Cell.CELL_TYPE_BLANK:
						value = "";
						break;
					default:
					}
					xlsxRawArray[i - rowStartOffset][j] = value;
				}

			}
			wb.close();
			ExcelFileToRead.close();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return xlsxRawArray;
	}

}
