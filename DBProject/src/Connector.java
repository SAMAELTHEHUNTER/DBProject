import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;
import java.util.StringTokenizer;

public class Connector {
    public boolean is_admin = false;

    public void run() {
        try {
            Scanner input = new Scanner(System.in);
            Class.forName("com.mysql.jdbc.Driver");
            Connection db = DriverManager.getConnection("jdbc:mysql://localhost:3306/storeproject", "root", "336285662252239");
            Statement st = db.createStatement();
            st.execute("GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;");
            int answer = 0;
            while (answer != 1 && answer != 2) {
                System.out.println("do you have account?");
                System.out.println("1-sign up");
                System.out.println("2-sign in");
                System.out.println("3-exit");
                answer = input.nextInt();
                if (answer == 1) {
                    signUp(db);
                    answer = 0;
                } else if (answer == 2) {
                    login(db);
                } else if (answer == 3) {
                    return;
                } else {
                    System.out.println("please enter valid input!");
                }
            }

            db.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void signUp(Connection db) throws SQLException {
        boolean is_signedUp = false;
        System.out.print("please enter your name: ");
        Scanner input = new Scanner(System.in);
        String name = input.next();
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select name from employee;");
        while (rs.next()) {
            if (name.equalsIgnoreCase(rs.getString(1))) {
                System.out.print("please enter your password: ");
                String password = input.next();
                st.execute("CREATE USER IF NOT EXISTS '" + name + "'@'127.0.0.1' IDENTIFIED BY '" + password + "'");
                st.execute("grant select, update on storeproject.employee to '" + name + "'@'127.0.0.1' with grant option;");
                st.execute("grant select, update on storeproject.customer to '" + name + "'@'127.0.0.1' with grant option;");
                st.execute("grant update, delete, select, insert on storeproject.ware to '" + name + "'@'127.0.0.1';");
                st.execute("update employee set password = '" + password + "' where name = '" + name + "' ;");
//                System.out.println("user: " + name + "password: " + password + "admin signup");
                is_signedUp = true;
                break;
            }
        }

        if (!is_signedUp) {
            rs = st.executeQuery("select name from customer;");
            while (rs.next()) {
                if (name.equalsIgnoreCase(rs.getString(1))) {
                    System.out.print("please enter your password: ");
                    String password = input.next();
                    st.execute("CREATE USER IF NOT EXISTS '" + name + "'@'127.0.0.1' IDENTIFIED BY '" + password + "'");
                    st.execute("grant select, update on storeproject.customer to '" + name + "'@'127.0.0.1';");
                    st.execute("update customer set password = '" + password + "' where name = '" + name + "' ;");
//                    System.out.println("user: " + name + "password: " + password + "not admin signup");
                    is_signedUp = true;
                    break;
                }
            }
        }
    }

    public boolean login(Connection db) throws SQLException {
        boolean is_login = false;
        Scanner input = new Scanner(System.in);
        System.out.print("please enter your name: ");
        String name = input.next();
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select name from employee;");
        while (rs.next()) {
            if (name.equalsIgnoreCase(rs.getString(1))) {
                System.out.print("please enter your password: ");
                String password = input.next();
                rs = st.executeQuery("select password from employee where password = '" + password + "';");
                while (rs.next()) {
                    if (password.equalsIgnoreCase(rs.getString(1))) {
                        is_admin = true;
                        Connection user = DriverManager.getConnection("jdbc:mysql://localhost:3306/storeproject", name, password);
//                        System.out.println("user: " + name + " password: " + password + " admin");
                        is_login = true;
                        userControl(user, name, db);
                        break;
                    } else {
                        System.out.println("wrong password!");
                    }
                }
                break;
            }
        }

        if (!is_login) {
            rs = st.executeQuery("select name from customer;");
            while (rs.next()) {
                if (name.equalsIgnoreCase(rs.getString(1))) {
                    System.out.print("please enter your password: ");
                    String password = input.next();
                    rs = st.executeQuery("select password from customer where password = '" + password + "';");
                    while (rs.next()) {
                        if (password.equalsIgnoreCase(rs.getString(1))) {
                            Connection user = DriverManager.getConnection("jdbc:mysql://localhost:3306/storeproject", name, password);
//                            System.out.println("user: " + name + "password: " + password + "not admin");
                            is_login = true;
                            userControl(user, name, db);
                            break;
                        } else {
                            System.out.println("wrong password!");
                        }
                    }
                    break;
                }
            }
        }


        return is_login;
    }

    public void userControl(Connection user, String name, Connection db) throws SQLException {
        System.out.println("you loged in as " + name);
        Scanner input = new Scanner(System.in);
        int answer = 0;
        while (answer != 3) {
            System.out.println("1-see prepared queries");
            System.out.println("2-code your self");
            System.out.println("3-exit");
            answer = input.nextInt();
            if (answer == 1) {
                preparedQueries(db, name);
                answer = 0;
                break;
            } else if (answer == 2) {
                code(user);
                answer = 0;
                break;
            } else if (answer == 3) {
                user.close();
                return;
            } else {
                System.out.println("please enter valid input!");
            }
        }
    }

    public void preparedQueries(Connection db, String name) throws SQLException {
        Scanner input = new Scanner(System.in);
        while (true) {
            System.out.println("which query you want to see?");
            System.out.println("1-ware list");
            System.out.println("2-users list");
            System.out.println("3-ware types");
            System.out.println("4-bill list");
            System.out.println("5-best users");
            System.out.println("6-best sellers");
            System.out.println("7-wares on off");
            System.out.println("8-sellers");//admin
            System.out.println("9-lowest price");//admin
            System.out.println("10-last 10 bills");
            System.out.println("11-comments");
            System.out.println("12-3 best comments");
            System.out.println("13-3 worst comments");
            System.out.println("14-amount of sell");//admin
            System.out.println("15-average of sell");//admin
            System.out.println("16-users of one city");
            System.out.println("17-providers");
            System.out.println("18-exit");
            int answer = input.nextInt();

            switch (answer) {
                case 1: {
                    wareList(db);
                    break;
                }
                case 2: {
                    usersList(db);
                    break;
                }
                case 3: {
                    wareTypes(db);
                    break;
                }
                case 4: {
                    billList(db);
                    break;
                }
                case 5: {
                    bestUsers(db);
                    break;
                }
                case 6: {
                    bestSellers(db);
                    break;
                }
                case 7: {
                    waresOnOff(db);
                    break;
                }
                case 8: {
                    sellers(db);
                    break;
                }
                case 9: {
                    lowestPrice(db);
                    break;
                }
                case 10: {
                    lastBills(db, name);
                    break;
                }
                case 11: {
                    comments(db);
                    break;
                }
                case 12: {
                    bestComments(db);
                    break;
                }
                case 13: {
                    worstComments(db);
                    break;
                }
                case 14: {
                    amountOfSell(db);
                    break;
                }
                case 15: {
                    avgOfSell(db);
                    break;
                }
                case 16: {
                    usersOfCity(db);
                    break;
                }
                case 17: {
                    providers(db);
                    break;
                }
                case 18: {
                    return;
                }
            }
        }
    }


    public void wareList(Connection db) throws SQLException {
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select * from ware;");
        ;
        while (rs.next()) {
            for (int i = 1; i <= 5; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void usersList(Connection db) throws SQLException {
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select * from customer as c join profile as p on p.Customer_ID = c.ID;");
        while (rs.next()) {
            for (int i = 1; i <= 10; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void wareTypes(Connection db) throws SQLException {
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select table_name from information_schema.tables\n" +
                "where table_name = 'dishwasher'or table_name = 'laundry'or table_name = 'solardom'or table_name = 'stove'or table_name = 'television';");
        while (rs.next()) {
            System.out.print(rs.getString(1));
        }
    }

    public void billList(Connection db) throws SQLException {
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select *  from cart;");
        while (rs.next()) {
            for (int i = 1; i <= 4; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }


    public void bestUsers(Connection db) throws SQLException {
        java.util.Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yy MM dd");
        String out = formatter.format(date);
        StringTokenizer stt = new StringTokenizer(out);
        int year = Integer.parseInt(stt.nextToken());
        int month = Integer.parseInt(stt.nextToken());
        int day = Integer.parseInt(stt.nextToken());
        year += 2000;
        StringBuilder last = new StringBuilder();
        last.append(year + "-" + month + "-" + day);
        month--;
        StringBuilder first = new StringBuilder();
        first.append(year + "-" + month + "-" + day);

        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select cu.ID , sum(b.Total_Price) as sum from customer as cu " +
                "join cart as c on cu.ID = c.Customer_ID " +
                "join bill as  b on b.Cart_CID = c.CID " +
                "where b.Is_Paid = 1 and b.date between '" + last + "' and '" + first + "' group by cu.ID order by sum desc limit 10;");
        while (rs.next()) {
            for (int i = 1; i <= 2; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }


    public void bestSellers(Connection db) throws SQLException {
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select WID, sum(whc.Count) as sum from ware as w\n" +
                "join ware_has_cart as whc on w.WID = whc.Ware_WID\n" +
                "join cart as c on whc.Cart_CID = c.CID\n" +
                "join bill as b on b.Cart_CID = c.CID\n" +
                "where b.Is_Paid = 1 group by w.WID order by sum desc limit 10;");
        while (rs.next()) {
            for (int i = 1; i <= 2; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void waresOnOff(Connection db) throws SQLException {
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select * from ware\n" +
                "where Discount > 15;\n");
        while (rs.next()) {
            for (int i = 1; i <= 5; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void sellers(Connection db) throws SQLException {
        if (is_admin) {
            Scanner input = new Scanner(System.in);
            System.out.println("which ware you want?");
            String ware = input.next();
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("select p.PID , p.Name from provider as p\n" +
                    "join provider_has_ware as phw on p.PID = phw.Provider_PID\n" +
                    "join ware as w on w.WID = phw.Ware_WID\n" +
                    "where w.name = '" + ware + "';");
            while (rs.next()) {
                for (int i = 1; i <= 2; i++) {
                    System.out.print(rs.getString(i) + " ");
                }
                System.out.println();
            }
        } else {
            System.out.println("you dont have permission");
        }
    }

    private void lowestPrice(Connection db) throws SQLException {
        if (is_admin) {
            Scanner input = new Scanner(System.in);
            System.out.println("which ware you want?");
            int ware = input.nextInt();
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("select w.WID , w.name , p.PID , p.Name , phw.price from provider_has_ware as phw\n" +
                    "join provider as p on phw.Provider_PID = p.PID\n" +
                    "join ware as w on w.WID = phw.Ware_WID\n" +
                    "where phw.Ware_WID = " + ware + " order by phw.price limit 1;");
            while (rs.next()) {
                for (int i = 1; i <= 2; i++) {
                    System.out.print(rs.getString(i) + " ");
                }
                System.out.println();
            }
        } else {
            System.out.println("you dont have permission");
        }
    }

    public void lastBills(Connection db, String name) throws SQLException {
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select *\n" +
                "from cart\n" +
                "join customer\n" +
                "on Customer_ID = ID\n" +
                "where customer.name = '" + name + "' " +
                "limit 10;");
        while (rs.next()) {
            for (int i = 1; i <= 9; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void comments(Connection db) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("which ware you want?");
        int ware = input.nextInt();
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select * from comments as c\n" +
                "join ware as w on w.WID = c.Ware_WID\n" +
                "where w.WID = " + ware + ";");
        while (rs.next()) {
            for (int i = 1; i <= 9; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void bestComments(Connection db) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("which ware you want?");
        int ware = input.nextInt();
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select max(rating) as rate, c.ID, w.WID, c.body from comments as c\n" +
                "join ware as w on w.WID = c.Ware_WID\n" +
                "where w.WID = " + ware + " group by c.ID order by rate desc limit 3;");
        while (rs.next()) {
            for (int i = 1; i <= 9; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void worstComments(Connection db) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("which ware you want?");
        int ware = input.nextInt();
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select max(rating) as rate, c.ID, w.WID, c.body from comments as c\n" +
                "join ware as w on w.WID = c.Ware_WID\n" +
                "where w.WID = " + ware + " group by c.ID order by rate asc limit 3;");
        while (rs.next()) {
            for (int i = 1; i <= 9; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void amountOfSell(Connection db) throws SQLException {
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yy MM dd");
        String out = formatter.format(date);
        StringTokenizer stt = new StringTokenizer(out);
        int year = Integer.parseInt(stt.nextToken());
        int month = Integer.parseInt(stt.nextToken());
        int day = Integer.parseInt(stt.nextToken());
        year += 2000;
        StringBuilder last = new StringBuilder();
        last.append(year + "-" + month + "-" + day);
        month--;
        StringBuilder first = new StringBuilder();
        first.append(year + "-" + month + "-" + day);

        Scanner input = new Scanner(System.in);
        System.out.println("which ware you want?");
        int ware = input.nextInt();

        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select sum(Count), Ware_WID\n" +
                "from bill as b\n" +
                "join cart as c on b.Cart_CID = c.CID\n" +
                "join ware_has_cart as whc on c.CID = whc.Cart_CID\n" +
                "where b.date between  '2022-08-01' and '2022-08-31' and whc.Ware_WID = " + ware + " ;");
        while (rs.next()) {
            for (int i = 1; i <= 2; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void avgOfSell(Connection db) throws SQLException {
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yy MM dd");
        String out = formatter.format(date);
        StringTokenizer stt = new StringTokenizer(out);
        int year = Integer.parseInt(stt.nextToken());
        int month = Integer.parseInt(stt.nextToken());
        int day = Integer.parseInt(stt.nextToken());
        year += 2000;
        StringBuilder last = new StringBuilder();
        last.append(year + "-" + month + "-" + day);
        month--;
        StringBuilder first = new StringBuilder();
        first.append(year + "-" + month + "-" + day);

        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select avg(Total_Price)\n" +
                "from bill\n" +
                "where Date between '2022-08-01' and '2022-08-31' and Is_Paid = 1;");
        while (rs.next()) {
            for (int i = 1; i <= 1; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void usersOfCity(Connection db) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("which city you want?");
        String city = input.next();

        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select *\n" +
                "from customer\n" +
                "where City = '" + city + "';");
        while (rs.next()) {
            for (int i = 1; i <= 5; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }

    public void providers(Connection db) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("which city you want?");
        String city = input.next();

        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("select *\n" +
                "from provider\n" +
                "where City = '" + city + "';");
        while (rs.next()) {
            for (int i = 1; i <= 3; i++) {
                System.out.print(rs.getString(i) + " ");
            }
            System.out.println();
        }
    }


    public void code(Connection user) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("enter your query:");
        String query = input.nextLine();
        StringTokenizer sy = new StringTokenizer(query);
        Statement st = user.createStatement();
        if (query.contains("select")) {
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                for (int i = 0; i < sy.countTokens(); i++) {
                    String s = sy.nextToken();
                    if (s.equalsIgnoreCase("from")) {
                        sy = new StringTokenizer(query);
                        break;
                    }
                    if (!s.equalsIgnoreCase("select") && !s.equalsIgnoreCase("from")) {
                        System.out.print(rs.getString(i) + " ");
                    }
                }
                System.out.println();
            }
        } else {
            st.execute(query);
        }
    }
}