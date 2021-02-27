import com.sweak.abstractsqlmodel 1.0

AbstractDayListView {
    model: AbstractSqlModel
    {
        query: "SELECT * FROM Tuesday ORDER BY ActivityTime ASC"
    }
}
